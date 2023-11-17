import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../shared/constants/colors.dart';

class FullImageScreenAll extends StatelessWidget {
  final String imageUrl;
  final bool isCheckNetwork;

  FullImageScreenAll({
    super.key,
    required this.imageUrl,
    required this.isCheckNetwork,
  });
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
        body: !isCheckNetwork
            ? Center(
                child: Image.asset(imageUrl),
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
