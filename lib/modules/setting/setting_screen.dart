import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/constants/string_constants.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/profile_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/stateless/item_setting_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/constants/assets_helper.dart';
import '../../shared/utils/size_utils.dart';
import '../auth/user_controller.dart';
import '../home/widgets/home_header.dart';
import '../profile/profile_controller.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

final ProfileController controller = Get.find();

class _SettingScreenState extends State<SettingScreen> {
  final UserController userController = Get.find();
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Obx(
      () => Scaffold(
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkBackground
            : ColorConstants.lightBackground,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(getSize(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(
                  size: size,
                ),
                SizedBox(
                  height: getSize(32),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.PROFILE),
                  child: ProfileWidget(
                    userController: userController,
                  ),
                ),
                SizedBox(
                  height: getSize(32),
                ),
                Text(
                  StringConst.appSetting.tr,
                  style: AppStyles.black000Size16Fw500FfMont.copyWith(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.white
                          : ColorConstants.black),
                ),
                SizedBox(
                  height: getSize(12),
                ),
                ItemSettingWidget(
                    title: StringConst.personalInformation.tr,
                    description: StringConst.yourAccountInformation.tr,
                    image: AssetHelper.icProfile),
                SizedBox(
                  height: getSize(16),
                ),
                ItemSettingWidget(
                    title: StringConst.notificationAndChat.tr,
                    description: StringConst.chatAndNotificationsSettings.tr,
                    image: AssetHelper.icNotification),
                SizedBox(
                  height: getSize(16),
                ),
                ItemSettingWidget(
                    title: StringConst.privateAndPermissions.tr,
                    description: StringConst.contactMyAlbum.tr,
                    image: AssetHelper.icShieldDone),
                SizedBox(
                  height: getSize(16),
                ),
                ItemSettingWidget(
                    title: StringConst.passwordAndAccount.tr,
                    description: StringConst.manageAccount.tr,
                    image: AssetHelper.icLock),
                SizedBox(
                  height: getSize(32),
                ),
                Text(
                  StringConst.settingSystem.tr,
                  style: AppStyles.black000Size16Fw500FfMont.copyWith(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.white
                          : ColorConstants.black),
                ),
                SizedBox(
                  height: getSize(16),
                ),
                ItemSettingWidget(
                    title: StringConst.changeLanguage.tr,
                    image: AssetHelper.icSetting),
                SizedBox(
                  height: getSize(16),
                ),
                ItemSettingWidget(
                  title: StringConst.darkMode.tr,
                  image: 'assets/images/x3/ic_dark_mode_profile.svg',
                  isSwitch: true,
                ),
                SizedBox(
                  height: getSize(32),
                ),
                Text(
                  StringConst.more.tr,
                  style: AppStyles.black000Size16Fw500FfMont.copyWith(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.white
                          : ColorConstants.black),
                ),
                SizedBox(
                  height: getSize(16),
                ),
                ItemSettingWidget(
                    title: StringConst.guide.tr, image: AssetHelper.icDocument),
                SizedBox(
                  height: getSize(16),
                ),
                ItemSettingWidget(
                    title: StringConst.feedback.tr,
                    image: AssetHelper.icEditSquare),
                SizedBox(
                  height: getSize(16),
                ),
                ItemSettingWidget(
                    title: StringConst.about.tr,
                    image: AssetHelper.icInfoSquare),
                SizedBox(
                  height: getSize(32),
                ),
                ListTile(
                  onTap: () {},
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringConst.logout.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: getSize(16),
                      ),
                      Image.asset(
                        AssetHelper.icoLogout,
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.lightBackground
                            : ColorConstants.graySub,
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
