import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../dark_mode.dart';
import '../../constants/app_style.dart';

class TitleHome extends StatefulWidget {
  const TitleHome({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<TitleHome> createState() => _TitleHomeState();
}

class _TitleHomeState extends State<TitleHome> {
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: AppStyles.black000Size20Fw500FfMont.copyWith(
          color: appController.isDarkModeOn.value
              ? ColorConstants.white
              : ColorConstants.black),
    );
  }
}
