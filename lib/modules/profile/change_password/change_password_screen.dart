import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/profile/change_password/change_password_controller.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/string_constants.dart';
import 'package:doan_clean_achitec/shared/utils/regex.dart';
import 'package:doan_clean_achitec/shared/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../shared/constants/colors.dart';
import '../../../shared/utils/app_bar_widget.dart';
import '../../../shared/utils/size_utils.dart';
import '../../../shared/widgets/my_button.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  ChangePasswordScreen({super.key});

  final AppController appController = Get.find();
  final ProfileController profileController = Get.put(ProfileController());
  final GlobalKey<FormState> changePassWord = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appController.isDarkModeOn.value
          ? ColorConstants.darkBackground
          : ColorConstants.lightBackground,
      appBar: CustomAppBar(
        titles: StringConst.changePassword.tr,
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkAppBar
            : ColorConstants.primaryButton,
        iconBgrColor: ColorConstants.grayTextField,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsets.all(getSize(20)),
            child: Obx(
              () => SingleChildScrollView(
                child: Form(
                  key: changePassWord,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getSize(24),
                      ),
                      Text(
                        StringConst.oldPassword.tr,
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
                        controller: controller.oldPasswordController,
                        hintText: '',
                        obscureText: controller.isOldPasswordVisible.value,
                        suffixIcon: GestureDetector(
                          onTap: () => controller.togglePasswordVisibility(
                            controller.isOldPasswordVisible,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(right: getSize(16)),
                            child: SvgPicture.asset(
                              controller.isOldPasswordVisible.value
                                  ? AssetHelper.icHide
                                  : AssetHelper.icShow,
                              color: ColorConstants.titleSearch,
                            ),
                          ),
                        ),
                        validatorCheck: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password don\'t empty';
                          }
                          if (!Regex.isPasswordAtLeast6Characters(
                              value.trim())) {
                            return 'Password must be at least 6 characters long';
                          }
                          if (!Regex.isPasswordUpcase(value.trim())) {
                            return 'Password must contain at least one capital letter';
                          }
                          if (!Regex.isPasswordNumber(value.trim())) {
                            return 'password must contain at least one number';
                          }
                          if (!Regex.isPasswordSpecialChar(value.trim())) {
                            return 'Password must contain at least one special character';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: getSize(16),
                      ),
                      Text(
                        StringConst.newPassword.tr,
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
                        controller: controller.newPasswordController,
                        hintText: '',
                        obscureText: controller.isNewPasswordVisible.value,
                        suffixIcon: GestureDetector(
                          onTap: () => controller.togglePasswordVisibility(
                            controller.isNewPasswordVisible,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(right: getSize(16)),
                            child: SvgPicture.asset(
                              controller.isNewPasswordVisible.value
                                  ? AssetHelper.icHide
                                  : AssetHelper.icShow,
                              color: ColorConstants.titleSearch,
                            ),
                          ),
                        ),
                        validatorCheck: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password don\'t empty';
                          }
                          if (!Regex.isPasswordAtLeast6Characters(
                              value.trim())) {
                            return 'Password must be at least 6 characters long';
                          }
                          if (!Regex.isPasswordUpcase(value.trim())) {
                            return 'Password must contain at least one capital letter';
                          }
                          if (!Regex.isPasswordNumber(value.trim())) {
                            return 'password must contain at least one number';
                          }
                          if (!Regex.isPasswordSpecialChar(value.trim())) {
                            return 'Password must contain at least one special character';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: getSize(16),
                      ),
                      Text(
                        StringConst.confirmNewPassword.tr,
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
                        controller: controller.newConfirmPasswordController,
                        hintText: '',
                        obscureText:
                            controller.isNewConfirmPasswordVisible.value,
                        suffixIcon: GestureDetector(
                          onTap: () => controller.togglePasswordVisibility(
                            controller.isNewConfirmPasswordVisible,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(right: getSize(16)),
                            child: SvgPicture.asset(
                              controller.isNewConfirmPasswordVisible.value
                                  ? AssetHelper.icHide
                                  : AssetHelper.icShow,
                              color: ColorConstants.titleSearch,
                            ),
                          ),
                        ),
                        validatorCheck: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password don\'t empty';
                          }
                          if (!Regex.isPasswordAtLeast6Characters(
                              value.trim())) {
                            return 'Password must be at least 6 characters long';
                          }
                          if (!Regex.isPasswordUpcase(value.trim())) {
                            return 'Password must contain at least one capital letter';
                          }
                          if (!Regex.isPasswordNumber(value.trim())) {
                            return 'password must contain at least one number';
                          }
                          if (!Regex.isPasswordSpecialChar(value.trim())) {
                            return 'Password must contain at least one special character';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: getSize(48),
                      ),
                      Center(
                        child: MyButton(
                          onTap: () async {
                            if (changePassWord.currentState!.validate()) {
                              controller.isChangePassword(
                                controller.oldPasswordController.text,
                                controller.newPasswordController.text,
                                controller.newConfirmPasswordController.text,
                              );
                            }
                          },
                          textBtn: StringConst.save.tr,
                          colorBgr: ColorConstants.primaryButton,
                        ),
                      ),
                      SizedBox(
                        height: getSize(16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
