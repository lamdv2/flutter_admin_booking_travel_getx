import 'dart:async';

import 'package:doan_clean_achitec/modules/auth/user_controller.dart';
import 'package:doan_clean_achitec/modules/home/home_controller.dart';
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

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final UserController userController =
      Get.put<UserController>(UserController());

  final HomeController homeController =
      Get.put<HomeController>(HomeController());

  late final Rx<User> firebaseUser;
  RxString veriticationId = ''.obs;

  void clearControllLogin() {
    loginEmailController.clear();
    loginPasswordController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerConfirmPasswordController.clear();
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
      } else if (loginEmailController.text != StringConst.adminEmail) {
        // ignore: use_build_context_synchronously
        wrongMessage(context, 'Email not found!!!');
      } else if (loginPasswordController.text != StringConst.adminPassword) {
        // ignore: use_build_context_synchronously
        wrongMessage(context, 'Error password!!!');
      } else {
        // ignore: use_build_context_synchronously
        wrongMessage(context, 'Something went wrong!!!');
      }
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      wrongMessage(context, e.code);
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
