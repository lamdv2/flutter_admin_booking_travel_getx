import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../dark_mode.dart';
import '../../../modules/auth/user_controller.dart';
import '../../constants/assets_helper.dart';
import '../../constants/colors.dart';
import '../../utils/size_utils.dart';

class ProfileWidget extends StatelessWidget {
  ProfileWidget({
    super.key,
    required this.userController,
  });

  final UserController userController;
  final AppController appController = Get.find();
  final ProfileController profileController = Get.find();
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    profileController.getUrlImage();
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: appController.isDarkModeOn.value
              ? ColorConstants.darkCard!
              : ColorConstants.white,
          borderRadius: BorderRadius.circular(getSize(24)),
        ),
        padding: EdgeInsets.all(getSize(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            homeController.userModel.value != null &&
                    homeController.userModel.value?.imgAvatar != null &&
                    homeController.userModel.value?.imgAvatar != "" &&
                    profileController.urlImage.value.isNotEmpty
                ? CircleAvatar(
                    radius: 64,
                    backgroundImage: CachedNetworkImageProvider(
                      profileController.urlImage.value,
                    ),
                  )
                : CircleAvatar(
                    radius: 64,
                    backgroundColor: ColorConstants.white,
                    child: Container(
                      width: getSize(96),
                      height: getSize(96),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                            appController.isDarkModeOn.value
                                ? ColorConstants.white
                                : ColorConstants.accent1,
                            BlendMode.srcIn,
                          ),
                          image: const AssetImage(
                            AssetHelper.imgUserProfileNon,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
            SizedBox(width: getSize(24)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userController.userName.value != ''
                        ? userController.userName.value
                        : "",
                    style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.white
                            : Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    userController.userEmail.value != ''
                        ? userController.userEmail.value
                        : '',
                    style: TextStyle(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.white
                          : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 16),
                    child: Divider(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.btnCanCel
                          : ColorConstants.graySecond,
                      thickness: getSize(0.5),
                      endIndent: getSize(16),
                    ),
                  ),
                  Text(
                    "+84 ${homeController.userModel.value?.phoneNub}",
                    style: TextStyle(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.white
                          : ColorConstants.titleSub,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 16),
                    child: Divider(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.btnCanCel
                          : ColorConstants.graySecond,
                      thickness: getSize(0.5),
                      endIndent: getSize(16),
                    ),
                  ),
                  Text(
                    '${homeController.userModel.value?.location}',
                    style: TextStyle(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.white
                          : ColorConstants.titleSub,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: getSize(4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
