import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextField extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validatorCheck;
  final bool? isTypeNumb;
  final bool? isCheckReadOnly;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.validatorCheck,
    this.isTypeNumb,
    this.isCheckReadOnly,
  }) : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      obscureText: widget.obscureText,
      style: AppStyles.black000Size14Fw400FfMont,
      keyboardType: widget.isTypeNumb != null && widget.isTypeNumb == true
          ? TextInputType.number
          : TextInputType.text,
      readOnly: widget.isCheckReadOnly != null && widget.isCheckReadOnly == true
          ? true
          : false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: ColorConstants.darkGray.withOpacity(.5),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: Colors.blue),
        ),
        fillColor: Colors.grey.shade100,
        labelText: widget.hintText,
        labelStyle: const TextStyle(
          color: ColorConstants.accent1,
          fontWeight: FontWeight.w400,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 1.5,
            color: ColorConstants.red,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 0.5,
            color: ColorConstants.red,
          ),
        ),
        isDense: true,
      ),
      validator: (widget.validatorCheck ??
          (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Don\'t empty';
            }
            return null;
          }),
      cursorColor: ColorConstants.primaryButton,
    );
  }
}
