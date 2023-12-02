import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/employee/employee.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeController extends GetxController {
  final GlobalKey<FormState> createEmployeeKey = GlobalKey<FormState>();

  final editEmailController = TextEditingController();
  final editFirstNameController = TextEditingController();
  final editLastNameController = TextEditingController();
  final editPassWordController = TextEditingController();
  final editImageAvatarController = TextEditingController();
  final editPhoneNumberController = TextEditingController();
  final editLocationController = TextEditingController();

  void createEmployee(EmployeeModel employeeModel) async {
    await FirebaseFirestore.instance
        .collection('employee')
        .add(employeeModel.toJson())
        .whenComplete(() {
      Get.back();
      Get.snackbar(
        "Success",
        "Your account have been created!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorConstants.blue.withOpacity(.1),
        colorText: ColorConstants.blue,
      );
      clearTextController();
    })
        // ignore: body_might_complete_normally_catch_error
        .catchError((error) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try again!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorConstants.red.withOpacity(.1),
        colorText: ColorConstants.red,
      );
    });
  }

  void clearTextController() {
    editEmailController.clear();
    editFirstNameController.clear();
    editLastNameController.clear();
    editPassWordController.clear();
    editImageAvatarController.clear();
    editPhoneNumberController.clear();
    editLocationController.clear();
  }
}
