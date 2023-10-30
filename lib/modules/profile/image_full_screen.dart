import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/profile/edit_profile.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../../../../shared/constants/colors.dart';

class FullImageScreen extends StatelessWidget {
  final String imageUrl;

  FullImageScreen({required this.imageUrl});
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          height: getSize(150),
          backgroundColor: appController.isDarkModeOn.value
              ? ColorConstants.gray
              : ColorConstants.white,
          // leadingWidth: getSize(68),
        ),
        body: profileController.imageFonts.value.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetEntityImageProvider(
                        profileController.imageFonts.value[0],
                      ),
                    ),
                  ),
                ),
              )
            : imageUrl == ""
                ? Center(
                    child: Image.asset(AssetHelper.imgUserProfileNon),
                  )
                : Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
      ),
    );
  }
}
