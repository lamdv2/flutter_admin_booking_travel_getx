import 'dart:async';

import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/auth/user_controller.dart';
import 'package:doan_clean_achitec/modules/home/home_controller.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
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

  final ProfileController _profileController =
      Get.put<ProfileController>(ProfileController());

  final UserController userController =
      Get.put<UserController>(UserController());

  final HomeController homeController =
      Get.put<HomeController>(HomeController());

  final _auth = FirebaseAuth.instance;
  late final Rx<User> firebaseUser;
  RxString veriticationId = ''.obs;

  void signInPhoneAuthentication(String phoneNub, UserModel userModel) {
    phoneAuthentication(phoneNub, userModel);
  }

  void clearControllLogin() {
    loginEmailController.clear();
    loginPasswordController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerConfirmPasswordController.clear();
  }

  Future<void> phoneAuthentication(String phoneNub, UserModel userModel) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNub,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (String verificationId, int? resendToken) async {
        veriticationId.value = verificationId;
        Get.toNamed(Routes.OTP_SCREEN, arguments: userModel);
      },
      codeAutoRetrievalTimeout: (veriticationId) {
        this.veriticationId.value = veriticationId;
      },
      timeout: const Duration(seconds: 60),
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar("Error", "The phone number invalid!");
        } else {
          // Get.snackbar("Error", "Something went wrong. Try again!");
          Get.snackbar("Error", "${e.code}. Try again!");
        }
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: veriticationId.value,
          smsCode: otp,
        ),
      );
      // ignore: unnecessary_null_comparison
      return credentials != null;
    } catch (error) {
      return false;
    }
  }

  void register(BuildContext context) async {
    AppFocus.unFocus(context);

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final email = registerEmailController.text;
      final password = registerPasswordController.text;

      final existingUser =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      if (existingUser.isNotEmpty) {
        // ignore: use_build_context_synchronously
        Get.back(result: context);
        // ignore: use_build_context_synchronously
        wrongMessage(context, "Email already in use");
        return;
      }

      if (password == registerConfirmPasswordController.text) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        final UID = FirebaseAuth.instance.currentUser?.uid;

        final userModel = UserModel(
          id: UID,
          email: email,
          passWord: password,
          phoneNub: "",
          isActive: true,
        );

        _profileController.createUser(userModel);

        Incorrect("Register Success");

        homeController.getUserDetails(userController.userEmail.value);

        clearControllLogin();

        // ignore: use_build_context_synchronously
        Get.back();
      } else {
        // ignore: use_build_context_synchronously
        Get.back();
        // ignore: use_build_context_synchronously
        wrongMessage(context, "Passwords don't match");
      }
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Get.back();
      // ignore: use_build_context_synchronously
      wrongMessage(context, "${e.code} register");
    }
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      );
      homeController.getUserDetails(userController.userEmail.value);
      clearControllLogin();

      Get.back();
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
    if (message == "weak-password") {
      errorMessage = "The password is too weak";
    } else if (message == "email-already-in-use") {
      errorMessage = "The email address is already in use";
    } else if (message == "user-not-found") {
      errorMessage = "User not found. Please register.";
    } else if (message == "wrong-password") {
      errorMessage = "Invalid password. Please try again.";
    } else if (message == "network-request-failed register") {
      errorMessage = "No internet. Please try again.";
    } else {
      errorMessage = "Something went wrong.";
    }

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
