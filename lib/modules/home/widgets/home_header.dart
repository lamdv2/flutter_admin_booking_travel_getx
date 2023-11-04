import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({
    super.key,
    required this.size,
    this.titleCenter,
    this.avatar,
  });

  final Size size;
  final String? titleCenter;
  final bool? avatar;

  final AppController appController = Get.find();
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  homeController.scaffoldHomeKey.currentState?.openDrawer();
                },
                child: Padding(
                  padding: EdgeInsets.only(right: getSize(6)),
                  child: Icon(
                    FontAwesomeIcons.bars,
                    size: getSize(kTop26Padding),
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.white
                        : Colors.black87,
                  ),
                ),
              ),
              Text(
                titleCenter ?? "",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.white
                        : ColorConstants.black),
              ),
              avatar != null
                  ? GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.PROFILE,
                            arguments: StringConst.userName);
                      },
                      child: Container(
                        width: getSize(36),
                        height: getSize(36),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: const BoxDecoration(
                          color: ColorConstants.secondColor,
                          borderRadius: kDefaultBorderRadius,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(AssetHelper.imgInfo),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(width: getSize(36)),
            ],
          ),
        ],
      ),
    );
  }
}
