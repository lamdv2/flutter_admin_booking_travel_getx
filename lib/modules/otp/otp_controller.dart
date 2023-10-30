import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/auth/auth.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final AuthController _authController = Get.find();
  final ProfileController _profileController = Get.find();

  Future<void> verifyOTP(String otp, UserModel userModel) async {
    bool isVerified = await _authController.verifyOTP(otp);
    if (isVerified) {
      Get.back();
      _profileController.createUser(userModel);
    } else {
      Get.snackbar(
        'OTP Verification Failed',
        'Please enter a valid OTP.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
