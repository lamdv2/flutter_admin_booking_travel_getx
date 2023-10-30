import 'package:doan_clean_achitec/modules/profile/edit_profile.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/stateless/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dark_mode.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/app_style.dart';
import '../../shared/utils/size_utils.dart';
import '../../shared/widgets/stateful/profile_widget.dart';
import '../auth/user_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final ProfileController controller = Get.put(ProfileController());

class _ProfileScreenState extends State<ProfileScreen> {
  final UserController userController = Get.find();
  final AppController appController = Get.find();

  @override
  void initState() {
    super.initState();
    profileController.getUrlImage();

  }

  @override
  Widget build(BuildContext context) {
    profileController.getUrlImage();

    return Scaffold(
      drawer: DrawerWidget(),
      appBar: CustomAppBar(
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkAppBar
            : ColorConstants.primaryButton,
        iconBgrColor: ColorConstants.grayTextField,
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
                ProfileWidget(
                  userController: userController,
                ),
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
                          Text(
                            "86",
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
                            StringConst.photo.tr,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "4k",
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
                            StringConst.followers.tr,
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "120",
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
                            StringConst.following.tr,
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
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(getSize(18)),
                            child: Image.asset(
                              AssetHelper.city_1,
                              height: getSize(126),
                              width: getSize(164),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(getSize(18)),
                            child: Image.asset(
                              AssetHelper.city_3,
                              height: getSize(126),
                              width: getSize(164),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(getSize(18)),
                            child: Image.asset(
                              AssetHelper.city_4,
                              height: getSize(126),
                              width: getSize(164),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(getSize(18)),
                            child: Image.asset(
                              AssetHelper.city_8,
                              height: getSize(126),
                              width: getSize(164),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(getSize(18)),
                      child: Image.asset(
                        AssetHelper.city_6,
                        height: getSize(136),
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
