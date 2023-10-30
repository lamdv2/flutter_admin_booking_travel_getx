import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../dark_mode.dart';

class ItemSettingWidget extends StatelessWidget {
  final AppController appController = Get.find();

  ItemSettingWidget({
    super.key,
    required this.title,
    this.description,
    required this.image,
    this.ontap,
    this.isSwitch,
  });

  final String title;
  final String? description;
  final String image;
  final Function()? ontap;
  final bool? isSwitch;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap ?? () {},
      child: Container(
        decoration: BoxDecoration(
          color: appController.isDarkModeOn.value
              ? ColorConstants.darkCard
              : ColorConstants.white,
          borderRadius: BorderRadius.circular(getSize(12)),
        ),
        padding: EdgeInsets.symmetric(
          vertical: getSize(12),
          horizontal: getSize(10),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: getSize(28),
              height: getSize(28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.all(getSize(4)),
              child: SvgPicture.asset(
                image,
                colorFilter: ColorFilter.mode(
                  appController.isDarkModeOn.value
                      ? ColorConstants.white
                      : ColorConstants.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: AppStyles.black000Size16Fw400FfMont.copyWith(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.white
                            : ColorConstants.black),
                  ),
                  SizedBox(
                    height: getSize(4),
                  ),
                  description != null
                      ? Text(
                          description ?? '',
                          style: AppStyles.botTitle000Size12Fw400FfMont
                              .copyWith(
                                  color: appController.isDarkModeOn.value
                                      ? ColorConstants.gray
                                      : ColorConstants.botTitle),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
            isSwitch != null
                ? SizedBox(
                    height: 24,
                    child: Obx(
                      () => Switch(
                        value: appController.isDarkModeOn.value,
                        activeTrackColor: appController.isDarkModeOn.value
                            ? Colors.white
                            : Colors.blueGrey,
                        activeColor: appController.isDarkModeOn.value
                            ? Colors.white
                            : Colors.lightBlue,
                        onChanged: (value) {
                          appController.toggleDarkMode();
                        },
                      ),
                    ),
                  )
                : SizedBox(
                    height: 24,
                    child: SvgPicture.asset(
                      AssetHelper.icoNextRight,
                      colorFilter: ColorFilter.mode(
                        appController.isDarkModeOn.value
                            ? ColorConstants.primaryBackground
                            : ColorConstants.titleSearch,
                        BlendMode.srcIn,
                      ),
                      width: getSize(24),
                      height: getSize(24),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
