import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_style.dart';
import '../../utils/size_utils.dart';

// ignore: must_be_immutable
class ItemTopHotel extends StatelessWidget {
  String nameHotel;
  String imgHotel;
  ItemTopHotel({
    super.key,
    required this.nameHotel,
    required this.imgHotel,
  });

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(getSize(16)),
          child: Image.asset(
            imgHotel,
            width: getSize(64),
            height: getSize(64),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: getSize(16),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: getSize(64)),
          child: Tooltip(
            message: nameHotel,
            preferBelow: false,
            child: Text(
              nameHotel,
              style: AppStyles.black000Size14Fw400FfMont.copyWith(
                color: appController.isDarkModeOn.value
                    ? ColorConstants.lightBackground
                    : ColorConstants.darkStatusBar,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ),
      ],
    );
  }
}
