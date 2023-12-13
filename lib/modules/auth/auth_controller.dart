import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/employee/employee.dart';
import 'package:doan_clean_achitec/modules/auth/user_controller.dart';
import 'package:doan_clean_achitec/modules/employee_role/home_role/home_controller_role.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:doan_clean_achitec/shared/utils/focus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  bool registerTermsChecked = false;
  RxBool isLoginPasswordVisible = true.obs;

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final UserController userController =
      Get.put<UserController>(UserController());

  final HomeRoleController homeRoleController =
      Get.put<HomeRoleController>(HomeRoleController());

  final ProfileController profileController = Get.put(ProfileController());
  final _db = FirebaseFirestore.instance;

  late final Rx<User> firebaseUser;
  RxString veriticationId = ''.obs;

  void clearControllLogin() {
    loginEmailController.clear();
    loginPasswordController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerConfirmPasswordController.clear();
  }

  void togglePasswordVisibility(RxBool isVisible) {
    isVisible.value = !isVisible.value;
  }

  void login(BuildContext context) async {
    AppFocus.unFocus(context);

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        Timer(
          const Duration(seconds: 1),
          () {
            Get.back();
          },
        );
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (loginEmailController.text == StringConst.adminEmail &&
          loginPasswordController.text == StringConst.adminPassword) {
        clearControllLogin();
        Get.offNamed(Routes.HOME);
        return;
      }

      final snapShot = await _db
          .collection('employee')
          .where('email', isEqualTo: loginEmailController.text)
          .where('passWord', isEqualTo: loginPasswordController.text)
          .get();

      if (snapShot.docs.isNotEmpty) {
        final listEmployeeData =
            snapShot.docs.map((doc) => EmployeeModel.fromJson(doc)).single;

        final fcmTokenGet = LocalStorageHelper.getValue('fcmToken') ?? "";
        profileController.createPushNotification(
          homeRoleController.employeeModel.value?.id ?? "",
          fcmTokenGet,
        );
        await LocalStorageHelper.setEmail(loginEmailController.text);

        clearControllLogin();

        Get.offAllNamed(Routes.HOME_SCREEN_ROLE);
        homeRoleController.employeeModel.value = listEmployeeData;
      } else {
        // ignore: use_build_context_synchronously
        wrongMessage(context, 'Authentication error');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        // ignore: use_build_context_synchronously
        wrongMessage(context, 'Invalid email or password');
      } else {
        // ignore: use_build_context_synchronously
        wrongMessage(context, e.message ?? 'Authentication error');
      }
    }
  }

  // ignore: non_constant_identifier_names
  void Incorrect(String text) {
    final context = Get.context;
    showDialog(
      context: context!,
      barrierDismissible: true,
      anchorPoint: const Offset(10, 10),
      builder: (context) {
        Timer(const Duration(seconds: 2), () {
          Get.back();
        });
        return Center(
          child: AlertDialog(
            title: Center(
              child: Text(text),
            ),
          ),
        );
      },
    );
  }

  // error message show dialog
  void wrongMessage(BuildContext context, String message) {
    String errorMessage = message;

    final contextGet = Get.context;
    showDialog(
      context: contextGet!,
      barrierDismissible: true,
      builder: (context) {
        Timer(
          const Duration(seconds: 4),
          () {
            Get.back();
          },
        );
        return AlertDialog(
          backgroundColor: ColorConstants.primaryButton,
          title: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        );
      },
    );
  }

  @override
  void onClose() {
    super.onClose();

    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerConfirmPasswordController.dispose();

    loginEmailController.dispose();
    loginPasswordController.dispose();
  }
}
