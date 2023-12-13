// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/employee_role/user_in_tour/user_in_tour_controller.dart';
import 'package:doan_clean_achitec/modules/tour/tour_controller.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/employee/employee.dart';

class UserInTourItemWidget extends GetView<UserInTourController> {
  UserModel userModel;
  bool isCheckListUserParti;
  UserInTourItemWidget({
    required this.userModel,
    required this.isCheckListUserParti,
    super.key,
  });

  TourController tourController = Get.put(TourController());
  AppController appController = Get.find();

  final listEmployeeOfTour = Rxn<List<EmployeeModel>>([]);
  RxBool isCheckSearch = false.obs;

  @override
  Widget build(BuildContext context) {
    controller.getAllCity();
    return GestureDetector(
      // onTap: () => Get.toNamed(
      //   Routes.TOUR_ROLE_DETAIL_SCREEN,
      //   arguments: userModel,
      // ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: appController.isDarkModeOn.value
              ? ColorConstants.darkCard
              : ColorConstants.white,
          borderRadius: BorderRadius.circular(getSize(16)),
          border: Border.all(
            color: appController.isDarkModeOn.value
                ? ColorConstants.darkCard.withOpacity(.4)
                : ColorConstants.dividerColor.withOpacity(.4),
            width: 2,
          ),
        ),
        margin: EdgeInsets.only(bottom: getSize(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(getSize(16)),
                  child: userModel.imgAvatar != null &&
                          userModel.imgAvatar!.isNotEmpty
                      ? CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: userModel.imgAvatar != null &&
                                  userModel.imgAvatar!.isNotEmpty
                              ? userModel.imgAvatar!
                              : 'https://firebasestorage.googleapis.com/v0/b/doan-final-travel.appspot.com/o/assets%2Fsystem%2Fic_nodata.png?alt=media&token=51128304-2989-4d9e-84b2-81155f0d06f8',
                        )
                      : Image.asset(
                          AssetHelper.imgPrevHotel01,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            SizedBox(
              width: getSize(6),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${userModel.firstName ?? ""} ${userModel.lastName ?? ""}",
                      style: AppStyles.botTitle000Size20Fw600FfMont.copyWith(
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.btnCanCel
                              : ColorConstants.botTitle),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                    SizedBox(
                      height: getSize(8.0),
                    ),
                    Text(
                      userModel.phoneNub,
                      style: AppStyles.botTitle000Size14Fw400FfMont.copyWith(
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.btnCanCel
                              : ColorConstants.botTitle),
                    ),
                    SizedBox(
                      width: getSize(8.0),
                    ),
                    Text(
                      userModel.email,
                      style: AppStyles.graySecondSize14Fw400FfMont.copyWith(
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.btnCanCel
                              : ColorConstants.graySecond),
                    ),
                    SizedBox(
                      height: getSize(4),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getSize(8),
            ),
            Expanded(
              flex: 1,
              child: isCheckListUserParti
                  ? const Icon(
                      Icons.check,
                      color: ColorConstants.green,
                    )
                  : const Icon(
                      Icons.warning_amber,
                      color: ColorConstants.green,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
