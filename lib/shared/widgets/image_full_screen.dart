import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          backgroundColor: appController.isDarkModeOn.value
              ? ColorConstants.gray
              : ColorConstants.white,
        ),
        body: imageUrl == ""
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
