import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../dark_mode.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/dimension_constants.dart';
import '../../../shared/widgets/stateful/title.dart';

class TitleDes extends StatelessWidget {
  TitleDes({
    super.key,
    required this.largeTitle,
    required this.seeAll,
    this.onTap,
  });

  final String largeTitle;
  final String seeAll;
  final VoidCallback? onTap;

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleHome(title: largeTitle),
        InkWell(
          onTap: onTap ?? () {},
          child: Text(
            seeAll,
            style: TextStyle(
              color: appController.isDarkModeOn.value
                  ? const Color.fromARGB(255, 142, 153, 247)
                  : ColorConstants.primaryButton,
              fontSize: kIconRadius,
            ),
          ),
        ),
      ],
    );
  }
}
