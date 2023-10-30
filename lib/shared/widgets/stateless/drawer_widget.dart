import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../modules/profile/profile_screen.dart';
import '../../../routes/app_pages.dart';
import '../../utils/size_utils.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({
    super.key,
  });

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .7,
      backgroundColor: appController.isDarkModeOn.value
          ? ColorConstants.darkBackground
          : ColorConstants.lightBackground,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: getSize(16 + MediaQuery.of(context).padding.top),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 24,
                  top: 16,
                ),
                child: SvgPicture.asset(
                  AssetHelper.icoNextLeft,
                  colorFilter: ColorFilter.mode(
                    appController.isDarkModeOn.value
                        ? ColorConstants.btnCanCel
                        : ColorConstants.graySub,
                    BlendMode.srcIn,
                  ),
                  width: getSize(22),
                  height: getSize(22),
                ),
              ),
            ),
          ),
          SizedBox(
            height: getSize(16),
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(
                  AssetHelper.icProfile,
                  colorFilter: ColorFilter.mode(
                    appController.isDarkModeOn.value
                        ? ColorConstants.btnCanCel
                        : ColorConstants.graySub,
                    BlendMode.srcIn,
                  ),
                  width: getSize(22),
                  height: getSize(22),
                ),
                SizedBox(
                  width: getSize(24),
                ),
                Text(
                  StringConst.profile.tr,
                  style: TextStyle(
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.btnCanCel
                        : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {
              Get.toNamed(Routes.PROFILE);
            },
          ),
          Divider(
            thickness: 0.5,
            color: appController.isDarkModeOn.value
                ? ColorConstants.btnCanCel
                : ColorConstants.black.withOpacity(0.8),
            indent: 16,
            endIndent: 80,
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(
                  AssetHelper.icBag,
                  colorFilter: ColorFilter.mode(
                    appController.isDarkModeOn.value
                        ? ColorConstants.btnCanCel
                        : ColorConstants.graySub,
                    BlendMode.srcIn,
                  ),
                  width: getSize(22),
                  height: getSize(22),
                ),
                SizedBox(
                  width: getSize(24),
                ),
                Text(
                  StringConst.booking.tr,
                  style: TextStyle(
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.btnCanCel
                        : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {
              homeController.currentIndex.value = 3;
              Get.back();
            },
          ),
          Divider(
            thickness: 0.5,
            color: appController.isDarkModeOn.value
                ? ColorConstants.btnCanCel
                : ColorConstants.black.withOpacity(0.8),
            indent: 16,
            endIndent: 80,
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(
                  AssetHelper.icoHotel,
                  colorFilter: ColorFilter.mode(
                    appController.isDarkModeOn.value
                        ? ColorConstants.btnCanCel
                        : ColorConstants.graySub,
                    BlendMode.srcIn,
                  ),
                  width: getSize(22),
                  height: getSize(22),
                ),
                SizedBox(
                  width: getSize(24),
                ),
                Text(
                  StringConst.hotels.tr,
                  style: TextStyle(
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.btnCanCel
                        : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {
              Get.toNamed(Routes.HOTEL);
            },
          ),
          Divider(
            thickness: 0.5,
            color: appController.isDarkModeOn.value
                ? ColorConstants.btnCanCel
                : ColorConstants.black.withOpacity(0.8),
            indent: 16,
            endIndent: 80,
          ),
          ListTile(
            title: Row(
              children: [
                Image.asset(
                  AssetHelper.icoRoom,
                  color: appController.isDarkModeOn.value
                      ? ColorConstants.btnCanCel
                      : ColorConstants.graySub,
                  width: getSize(22),
                  height: getSize(22),
                ),
                SizedBox(
                  width: getSize(24),
                ),
                Text(
                  StringConst.rooms.tr,
                  style: TextStyle(
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.btnCanCel
                        : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {
              Get.toNamed(Routes.ROOM);
            },
          ),
          Divider(
            thickness: 0.5,
            color: appController.isDarkModeOn.value
                ? ColorConstants.btnCanCel
                : ColorConstants.black.withOpacity(0.8),
            indent: 16,
            endIndent: 80,
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(
                  AssetHelper.icDocument,
                  colorFilter: ColorFilter.mode(
                    appController.isDarkModeOn.value
                        ? ColorConstants.btnCanCel
                        : ColorConstants.graySub,
                    BlendMode.srcIn,
                  ),
                  width: getSize(22),
                  height: getSize(22),
                ),
                SizedBox(
                  width: getSize(24),
                ),
                Text(
                  StringConst.history.tr,
                  style: TextStyle(
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.btnCanCel
                        : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {
              Get.toNamed(Routes.HISTORY_TOUR_SCREEN);
            },
          ),
          Divider(
            thickness: 0.5,
            color: appController.isDarkModeOn.value
                ? ColorConstants.btnCanCel
                : ColorConstants.black.withOpacity(0.8),
            indent: 16,
            endIndent: 80,
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(
                  AssetHelper.icWallet,
                  colorFilter: ColorFilter.mode(
                    appController.isDarkModeOn.value
                        ? ColorConstants.btnCanCel
                        : ColorConstants.graySub,
                    BlendMode.srcIn,
                  ),
                  width: getSize(22),
                  height: getSize(22),
                ),
                SizedBox(
                  width: getSize(24),
                ),
                Text(
                  StringConst.tours.tr,
                  style: TextStyle(
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.btnCanCel
                        : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {
              Get.toNamed(Routes.TOUR);
            },
          ),
          Divider(
            thickness: 0.5,
            color: appController.isDarkModeOn.value
                ? ColorConstants.btnCanCel
                : ColorConstants.black.withOpacity(0.8),
            indent: 16,
            endIndent: 80,
          ),
          ListTile(
            title: Row(
              children: [
                SvgPicture.asset(
                  AssetHelper.icAddUser,
                  colorFilter: ColorFilter.mode(
                    appController.isDarkModeOn.value
                        ? ColorConstants.btnCanCel
                        : ColorConstants.graySub,
                    BlendMode.srcIn,
                  ),
                  width: getSize(22),
                  height: getSize(22),
                ),
                SizedBox(
                  width: getSize(24),
                ),
                Text(
                  StringConst.admins.tr,
                  style: TextStyle(
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.btnCanCel
                        : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            onTap: () {
              Get.toNamed(Routes.ADMIN_SCREEN);
            },
          ),
          Divider(
            thickness: 0.5,
            color: appController.isDarkModeOn.value
                ? ColorConstants.btnCanCel
                : ColorConstants.black.withOpacity(0.8),
            indent: 16,
            endIndent: 80,
          ),
          SizedBox(
            height: getSize(32),
          ),
          InkWell(
            onTap: () {
              controller.signUserOut(context);
              Get.offNamed(Routes.AUTH);
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
    );
  }
}
