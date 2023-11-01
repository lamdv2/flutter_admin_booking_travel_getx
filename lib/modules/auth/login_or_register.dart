import 'package:doan_clean_achitec/modules/auth/auth.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
