import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/string_constants.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/utils/regex.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/services/auth_service.dart';
import '../../shared/widgets/my_button.dart';
import '../../shared/widgets/my_textfield.dart';
import '../../shared/widgets/square_tile.dart';
import 'auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final Function()? onTap;
  LoginScreen({super.key, this.onTap});

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
                    Form(
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
                            obscureText: true,
                            validatorCheck: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Password don\'t empty';
                              }
                              if (!Regex.isPasswordAtLeast6Characters(
                                  value.trim())) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
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
                        // google
                        SquareTile(
                          onTap: () => AuthService().signInWithGoogle(),
                          imgPath: AssetHelper.imgGoogle,
                        ),

                        //Image(image: AssetImage('lib/images/apple.png'), height: 30,),
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

                    // not a member? register
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member?',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: onTap,
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
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
