// ignore_for_file: must_be_immutable

import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/models/employee/employee.dart';
import 'package:doan_clean_achitec/modules/employee/employee_controller.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/constants/colors.dart';
import '../../shared/constants/string_constants.dart';
import '../../shared/utils/regex.dart';
import '../../shared/utils/size_utils.dart';
import '../../shared/widgets/my_button.dart';
import '../../shared/widgets/my_textfield.dart';

class EmployeeCreateScreen extends StatelessWidget {
  EmployeeCreateScreen({super.key});
  final AppController appController = Get.find();

  EmployeeController controller = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titles: "Create Account Employee",
        iconBgrColor: ColorConstants.lightStatusBar,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(getSize(20)),
            child: Form(
              key: controller.createEmployeeKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getSize(24),
                  ),
                  Text(
                    "Email",
                    style: TextStyle(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.lightBackground
                          : ColorConstants.graySub,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  MyTextField(
                    controller: controller.emplEmailController,
                    hintText: 'Enter your employee',
                    obscureText: false,
                    validatorCheck: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email don\'t empty';
                      }
                      if (!Regex.isEmail(value.trim())) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: getSize(24),
                  ),
                  Text(
                    "First name",
                    style: TextStyle(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.lightBackground
                          : ColorConstants.graySub,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  MyTextField(
                    controller: controller.emplFirstNameController,
                    hintText: 'Enter your firstname',
                    obscureText: false,
                  ),
                  SizedBox(
                    height: getSize(24),
                  ),
                  Text(
                    "Last name",
                    style: TextStyle(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.lightBackground
                          : ColorConstants.graySub,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  MyTextField(
                    controller: controller.emplLastNameController,
                    hintText: 'Enter your last name',
                    obscureText: false,
                  ),
                  SizedBox(
                    height: getSize(24),
                  ),
                  Text(
                    "Phone number",
                    style: TextStyle(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.lightBackground
                          : ColorConstants.graySub,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  MyTextField(
                    controller: controller.emplPhoneNumberController,
                    hintText: "Enter your phone number",
                    obscureText: false,
                    isTypeNumb: true,
                    validatorCheck: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Phone number don\'t empty';
                      }
                      if (!Regex.isAllDigits(value.trim())) {
                        return 'Phone number must is number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: getSize(24),
                  ),
                  Text(
                    "Location",
                    style: TextStyle(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.lightBackground
                          : ColorConstants.graySub,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  MyTextField(
                    controller: controller.emplLocationController,
                    hintText: "Enter your location",
                    obscureText: false,
                  ),
                  SizedBox(
                    height: getSize(48),
                  ),
                  Center(
                    child: MyButton(
                      onTap: () async {
                        final employee = EmployeeModel(
                          email: controller.emplEmailController.text.trim(),
                          firstName:
                              controller.emplFirstNameController.text.trim(),
                          lastName:
                              controller.emplLastNameController.text.trim(),
                          phoneNub:
                              controller.emplPhoneNumberController.text.trim(),
                          location:
                              controller.emplLocationController.text.trim(),
                          passWord: "Abc123!@#",
                          imgAvatar: "",
                          isActive: true,
                        );
                        if (controller.createEmployeeKey.currentState!
                            .validate()) {
                          controller.createEmployee(employee);
                        }
                      },
                      textBtn: StringConst.create.tr,
                      colorBgr: ColorConstants.primaryButton,
                    ),
                  ),
                  SizedBox(
                    height: getSize(24),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
