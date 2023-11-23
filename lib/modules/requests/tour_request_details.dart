import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/models/history/history_model.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/requests/request_controller.dart';
import 'package:doan_clean_achitec/shared/constants/dimension_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../models/history_tour/history_tour_controller.dart';
import '../../shared/constants/app_style.dart';
import '../../shared/constants/assets_helper.dart';
import '../../shared/constants/colors.dart';
import '../../shared/utils/size_utils.dart';

// ignore: must_be_immutable
class TourRequestDetails extends GetView<RequestController> {
  TourRequestDetails({super.key});

  final TourModel? tourModel = Get.arguments['arg1'];
  final HistoryModel? historyModel = Get.arguments['arg2'];
  final UserModel? userModel = Get.arguments['arg3'];

  HistoryTourController historyTourController =
      Get.put(HistoryTourController());
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorConstants.lightCard,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(getSize(8)),
                    child: tourModel?.images != null && tourModel?.images != []
                        ? CachedNetworkImage(
                            height: getSize(240),
                            width: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: tourModel?.images?.first ?? '',
                          )
                        : Image.asset(
                            AssetHelper.city_1,
                            height: getSize(200),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + getSize(16),
                        left: getSize(16),
                      ),
                      child: InkWell(
                        onTap: () => Get.back(),
                        borderRadius: BorderRadius.circular(kIconRadius),
                        child: Container(
                          height: getSize(36),
                          width: getSize(36),
                          padding: EdgeInsets.all(getSize(kItemPadding)),
                          decoration: const BoxDecoration(
                            color: ColorConstants.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(kItemPadding),
                            ),
                          ),
                          child: SvgPicture.asset(
                            AssetHelper.icoNextLeft,
                            colorFilter: const ColorFilter.mode(
                              ColorConstants.accent1,
                              BlendMode.srcIn,
                            ),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getSize(20),
                  vertical: getSize(16),
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      historyModel?.bookingDate == null
                          ? ""
                          : historyTourController.timestampToStringHour(
                              historyModel?.bookingDate ?? Timestamp.now()),
                      style: AppStyles.titleSearchSize16Fw400FfMont.copyWith(
                        color: ColorConstants.flights,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Text(
                      tourModel?.nameTour ?? '',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: AppStyles.black000Size16Fw500FfMont,
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    tourModel?.accommodation != null
                        ? Column(
                            children: [
                              Text(
                                "Start at: ${tourModel?.accommodation ?? ''}",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style: AppStyles.titleSearchSize16Fw400FfMont
                                    .copyWith(
                                  color: appController.isDarkModeOn.value
                                      ? ColorConstants.dividerColor
                                      : ColorConstants.botTitle,
                                ),
                              ),
                              SizedBox(
                                height: getSize(16),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    tourModel?.accommodation != null
                        ? Column(
                            children: [
                              Text(
                                "Duration: ${tourModel?.duration ?? ''} day",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                style: AppStyles.titleSearchSize16Fw400FfMont
                                    .copyWith(
                                  color: appController.isDarkModeOn.value
                                      ? ColorConstants.dividerColor
                                      : ColorConstants.botTitle,
                                ),
                              ),
                              SizedBox(
                                height: getSize(16),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AssetHelper.icSend,
                          width: getSize(20),
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.dividerColor
                              : ColorConstants.botTitle,
                        ),
                        SizedBox(
                          width: getSize(16),
                        ),
                        Text(
                          userModel?.email ?? '',
                          style:
                              AppStyles.titleSearchSize16Fw400FfMont.copyWith(
                            color: appController.isDarkModeOn.value
                                ? ColorConstants.dividerColor
                                : ColorConstants.botTitle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    userModel?.phoneNub != null
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    AssetHelper.icCall,
                                    width: getSize(20),
                                    color: appController.isDarkModeOn.value
                                        ? ColorConstants.dividerColor
                                        : ColorConstants.botTitle,
                                  ),
                                  SizedBox(
                                    width: getSize(16),
                                  ),
                                  Text(
                                    userModel?.phoneNub ?? '',
                                    style: AppStyles
                                        .titleSearchSize16Fw400FfMont
                                        .copyWith(
                                      color: appController.isDarkModeOn.value
                                          ? ColorConstants.dividerColor
                                          : ColorConstants.botTitle,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getSize(16),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    historyModel?.adult != null ||
                            historyModel?.children != null
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    AssetHelper.icBookmark,
                                    width: getSize(20),
                                    color: appController.isDarkModeOn.value
                                        ? ColorConstants.dividerColor
                                        : ColorConstants.botTitle,
                                  ),
                                  SizedBox(
                                    width: getSize(16),
                                  ),
                                  Text(
                                    "Adult: ${historyModel?.adult?.toInt() ?? "0"}, children: ${historyModel?.children?.toInt() ?? "0"} ",
                                    style: AppStyles
                                        .titleSearchSize16Fw400FfMont
                                        .copyWith(
                                      color: appController.isDarkModeOn.value
                                          ? ColorConstants.dividerColor
                                          : ColorConstants.botTitle,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getSize(16),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AssetHelper.icCalendar,
                          width: getSize(20),
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.dividerColor
                              : ColorConstants.botTitle,
                        ),
                        SizedBox(
                          width: getSize(16),
                        ),
                        Text(
                          '${controller.timestampToString(
                            tourModel?.startDate ?? Timestamp.now(),
                          )} - ${controller.timestampToString(
                            tourModel?.endDate ?? Timestamp.now(),
                          )}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              AppStyles.titleSearchSize14Fw400FfMont.copyWith(
                            color: appController.isDarkModeOn.value
                                ? ColorConstants.dividerColor
                                : ColorConstants.botTitle,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AssetHelper.icBuy,
                          width: getSize(20),
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.dividerColor
                              : ColorConstants.botTitle,
                        ),
                        SizedBox(
                          width: getSize(16),
                        ),
                        Text(
                          '${historyModel?.totalPrice} VND',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: AppStyles.blue000Size14Fw400FfMont,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
