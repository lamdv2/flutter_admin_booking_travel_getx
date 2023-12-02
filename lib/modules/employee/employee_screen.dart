// ignore_for_file: must_be_immutable

import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/employee/employee.dart';
import 'package:doan_clean_achitec/modules/employee/employee_create_screen.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../shared/utils/size_utils.dart';

class EmployeeScreen extends GetView<EmployeeController> {
  EmployeeScreen({super.key});

  final AppController appController = Get.find();
  @override
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Create",
                        style: TextStyle(
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.lightBackground
                              : ColorConstants.graySub,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: getSize(16),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(EmployeeCreateScreen()),
                        child: SvgPicture.asset(
                          AssetHelper.icPlus,
                          width: getSize(28),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
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
    );
  }
}
