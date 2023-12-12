import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/modules/profile/edit_profile.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/profile_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/stateless/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dark_mode.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/app_style.dart';
import '../../shared/utils/size_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    profileController.getThumbnails();
    return WillPopScope(
      onWillPop: () async {
        if (homeRoleController.currentIndex.value != 0) {
          homeRoleController.currentIndex.value = 0;
          return false;
        }
        return true;
      },
      child: Scaffold(
        drawer: DrawerWidget(),
        appBar: CustomAppBar(
          backgroundColor: appController.isDarkModeOn.value
              ? ColorConstants.darkAppBar
              : ColorConstants.primaryButton,
          iconBgrColor: ColorConstants.grayTextField,
          onTap: () {
            if (homeRoleController.currentIndex.value != 0) {
              homeRoleController.currentIndex.value = 0;
            }
          },
        ),
        body: Obx(
          () => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(getSize(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getSize(8),
                  ),
                  Text(
                    StringConst.myProfile.tr,
                    style: TextStyle(
                      fontSize: 36,
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.white
                          : ColorConstants.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: getSize(28),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StringConst.personalDetail.tr,
                        style: AppStyles.black000Size20Fw500FfMont.copyWith(
                            color: appController.isDarkModeOn.value
                                ? ColorConstants.white
                                : ColorConstants.black),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.EDIT_PROFILE);
                        },
                        child: Text(
                          StringConst.change.tr,
                          style: AppStyles.black000Size16Fw400FfMont.copyWith(
                            color: appController.isDarkModeOn.value
                                ? ColorConstants.btnGradient
                                : ColorConstants.primaryButton,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(24),
                  ),
                  ProfileWidget(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(getSize(16)),
                    ),
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 24,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text(
                                "${profileController.userModelImg.value?.length ?? 0}",
                                style: TextStyle(
                                  color: appController.isDarkModeOn.value
                                      ? ColorConstants.white
                                      : ColorConstants.black.withOpacity(0.8),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Tour upcoming".tr,
                              style: TextStyle(
                                color: appController.isDarkModeOn.value
                                    ? ColorConstants.white
                                    : ColorConstants.black.withOpacity(0.4),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "0",
                                style: TextStyle(
                                  color: appController.isDarkModeOn.value
                                      ? ColorConstants.white
                                      : ColorConstants.black.withOpacity(0.8),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Tour completed".tr,
                                style: TextStyle(
                                  color: appController.isDarkModeOn.value
                                      ? ColorConstants.white
                                      : ColorConstants.black.withOpacity(0.4),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "0",
                                style: TextStyle(
                                  color: appController.isDarkModeOn.value
                                      ? ColorConstants.white
                                      : ColorConstants.black.withOpacity(0.8),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "All".tr,
                                style: TextStyle(
                                  color: appController.isDarkModeOn.value
                                      ? ColorConstants.white
                                      : ColorConstants.black.withOpacity(0.4),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() => GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            profileController.userModelImg.value?.length ?? 0,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: getSize(8),
                          mainAxisSpacing: getSize(8),
                        ),
                        itemBuilder: (context, index) {
                          String thumbnail =
                              profileController.userModelImg.value![index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(getSize(8)),
                            child: CachedNetworkImage(
                              imageUrl: thumbnail,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      profileController.signUserOut(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: appController.isDarkModeOn.value
                                      ? ColorConstants.btnCanCel
                                      : ColorConstants.black.withOpacity(0.8),
                                  width: 1,
                                ),
                              ),
                            ),
                            padding: EdgeInsets.only(bottom: getSize(8)),
                            child: Text(
                              StringConst.logout.tr,
                              style: TextStyle(
                                color: appController.isDarkModeOn.value
                                    ? ColorConstants.btnCanCel
                                    : ColorConstants.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Image.asset(
                            AssetHelper.icoLogout,
                            color: appController.isDarkModeOn.value
                                ? ColorConstants.btnCanCel
                                : ColorConstants.graySub,
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
