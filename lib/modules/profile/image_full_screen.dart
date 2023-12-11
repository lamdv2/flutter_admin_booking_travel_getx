import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/profile/edit_profile.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../../../../../shared/constants/colors.dart';

class FullImageScreen extends StatelessWidget {
  final String imageUrl;

  FullImageScreen({super.key, required this.imageUrl});
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          backgroundColor: appController.isDarkModeOn.value
              ? ColorConstants.gray
              : ColorConstants.white,
        ),
        body: profileController.imageFonts.value.isNotEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetEntityImageProvider(
                          profileController.imageFonts.value[0],
                        ),
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
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                      ),
                    ),
                  ),
      ),
    );
  }
}
