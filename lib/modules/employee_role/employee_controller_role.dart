import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/employee/employee.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeRoleController extends GetxController {
  final GlobalKey<FormState> createEmployeeKey = GlobalKey<FormState>();

  final _db = FirebaseFirestore.instance;

  final listAllEmployee = Rxn<List<EmployeeModel>>([]);
  final listAllEmployeeDeactive = Rxn<List<EmployeeModel>>([]);

  final emplEmailController = TextEditingController();
  final emplFirstNameController = TextEditingController();
  final emplLastNameController = TextEditingController();
  final emplPassWordController = TextEditingController();
  final emplImageAvatarController = TextEditingController();
  final emplPhoneNumberController = TextEditingController();
  final emplLocationController = TextEditingController();

  @override
  void onInit() {
    getAllEmployee();
    getAllEmployeeDeactive();
    super.onInit();
  }

  void createEmployee(EmployeeModel employeeModel) async {
    bool isEmailExists = await isEmailAlreadyExists(employeeModel.email);

    if (isEmailExists) {
      Get.snackbar(
        "Error",
        "Email already exists. Please use a different email.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorConstants.red.withOpacity(.1),
        colorText: ColorConstants.red,
      );
      return;
    }

    await FirebaseFirestore.instance
        .collection('employee')
        .add(employeeModel.toJson())
        .whenComplete(() {
      getAllEmployee();
      Get.back();
      Get.snackbar(
        "Success",
        "Your account has been created!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorConstants.blue.withOpacity(.1),
        colorText: ColorConstants.blue,
      );
      clearTextController();
    }).catchError(
      // ignore: body_might_complete_normally_catch_error
      (error) {
        Get.snackbar(
          "Error",
          "Something went wrong. Try again!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorConstants.red.withOpacity(.1),
          colorText: ColorConstants.red,
        );
      },
    );
  }

  Future<bool> isEmailAlreadyExists(String email) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('employee')
        .where('email', isEqualTo: email)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> getAllEmployee() async {
    final snapShot = await _db
        .collection('employee')
        .where('isActive', isEqualTo: true)
        .get();
    final listEmployeeData =
        snapShot.docs.map((doc) => EmployeeModel.fromJson(doc)).toList();

    listEmployeeData.sort((a, b) => a.firstName!.compareTo(b.firstName ?? ""));

    listAllEmployee.value = listEmployeeData;
  }

  Future<void> getAllEmployeeDeactive() async {
    final snapShot = await _db
        .collection('employee')
        .where('isActive', isEqualTo: false)
        .get();
    final listEmployeeData =
        snapShot.docs.map((doc) => EmployeeModel.fromJson(doc)).toList();

    listEmployeeData.sort((a, b) => a.firstName!.compareTo(b.firstName ?? ""));

    listAllEmployeeDeactive.value = listEmployeeData;
  }

  Future<void> deActiveEmployee(String employeeId) async {
    try {
      final DocumentReference employeeRef =
          FirebaseFirestore.instance.collection('employee').doc(employeeId);

      await employeeRef.update({'isActive': false});
      Get.snackbar("Success", "Employee deactivated successfully");
      getAllEmployee();
      getAllEmployeeDeactive();
    } catch (e) {
      Get.snackbar("Error", "Error deactivating employee");
    }
  }

  Future<void> reActiveEmployee(String employeeId) async {
    try {
      final DocumentReference employeeRef =
          FirebaseFirestore.instance.collection('employee').doc(employeeId);

      await employeeRef.update({'isActive': true});
      Get.snackbar("Success", "Employee reactivated successfully");
      getAllEmployee();
      getAllEmployeeDeactive();
    } catch (e) {
      Get.snackbar("Error", "Error reactivating employee");
    }
  }

  void clearTextController() {
    emplEmailController.clear();
    emplFirstNameController.clear();
    emplLastNameController.clear();
    emplPassWordController.clear();
    emplImageAvatarController.clear();
    emplPhoneNumberController.clear();
    emplLocationController.clear();
  }
}
