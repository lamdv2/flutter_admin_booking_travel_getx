import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/utils/regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController controller = Get.put(AuthController());

  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Image.asset(
                      AssetHelper.icLogoApp,
                      fit: BoxFit.cover,
                      width: getSize(84),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Text(
                      "Welcome to Travel App DreamTeam",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    Obx(
                      () => Form(
                        key: loginKey,
                        child: Column(
                          children: [
                            MyTextField(
                              controller: controller.loginEmailController,
                              hintText: "Enter your email",
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
                            const SizedBox(
                              height: 16,
                            ),
                            MyTextField(
                              controller: controller.loginPasswordController,
                              hintText: "Enter your password",
                              obscureText:
                                  controller.isLoginPasswordVisible.value,
                              suffixIcon: GestureDetector(
                                onTap: () =>
                                    controller.togglePasswordVisibility(
                                  controller.isLoginPasswordVisible,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(right: getSize(16)),
                                  child: SvgPicture.asset(
                                    controller.isLoginPasswordVisible.value
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
                                if (!Regex.isPasswordSpecialChar(
                                    value.trim())) {
                                  return 'Password must contain at least one special character';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            MyButton(
                              onTap: () {
                                if (loginKey.currentState!.validate()) {
                                  controller.login(context);
                                }
                              },
                              textBtn: 'Sign In',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          Text(
                            " or continue with ",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Warning!!!'),
                                  content:
                                      const Text("The feature is coming soon"),
                                  actions: [
                                    TextButton(
                                      onPressed: Get.back,
                                      child: Text(
                                        StringConst.ok.tr,
                                        style:
                                            AppStyles.blue000Size14Fw600FfMont,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          imgPath: AssetHelper.imgGoogle,
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        SquareTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Warning!!!'),
                                  content:
                                      const Text("The feature is coming soon"),
                                  actions: [
                                    TextButton(
                                      onPressed: Get.back,
                                      child: Text(
                                        StringConst.ok.tr,
                                        style:
                                            AppStyles.blue000Size14Fw600FfMont,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          imgPath: AssetHelper.imgApple,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
