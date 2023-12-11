import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/requests/request.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';

import '../../models/history/history_model.dart';
import '../../models/history_tour/history_tour_controller.dart';
import '../../models/tour/tour_model.dart';
import '../../shared/constants/app_style.dart';
import '../../shared/constants/assets_helper.dart';
import '../../shared/constants/colors.dart';
import '../../shared/utils/size_utils.dart';

class RequestScreen extends GetView<RequestController> {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getAllTourModelData();
      controller.loadIndicatorRive();
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: HistoryItemFinish(),
        ),
      ),
    );
  }
}

class HistoryItemFinish extends StatelessWidget {
  HistoryItemFinish({super.key});

  final AppController appController = Get.find();
  final RequestController controller = Get.put(RequestController());
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.refreshHistory(),
      child: Obx(
        () => controller.isShowLoading.value
            ? Center(
                child: SizedBox(
                  height: getSize(120),
                  width: getSize(120),
                  child: RiveAnimation.asset(
                    "assets/icons/riv/ic_checkerror.riv",
                    onInit: (artboard) {
                      StateMachineController stateMachineController =
                          controller.getRiveController(artboard);
                      controller.check =
                          stateMachineController.findSMI("Check") as SMITrigger;
                      controller.error =
                          stateMachineController.findSMI("Error") as SMITrigger;
                      controller.reset =
                          stateMachineController.findSMI("Reset") as SMITrigger;
                    },
                  ),
                ),
              )
            : controller.getListHisWaiting.value != null &&
                    controller.getListHisWaiting.value!.isNotEmpty
                ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: getSize(16),
                        horizontal: getSize(24),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            controller.getListHisWaiting.value?.length ?? 2,
                        itemBuilder: (BuildContext context, int rowIndex) {
                          return GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: getSize(12)),
                              child: _buildItemHistory(
                                tourModel: controller
                                    .getListHisWaiting.value?[rowIndex],
                                historyModel: controller
                                    .getListHisWaitingToDate.value?[rowIndex],
                                userModel: controller
                                    .getAllListUserWaiting.value?[rowIndex],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            AssetHelper.imgLottieNodate,
                            width: getSize(200),
                            height: getSize(200),
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: getSize(24),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getSize(48.0),
                            ),
                            child: Text(
                              'No tours require approval!',
                              style:
                                  AppStyles.black000Size14Fw400FfMont.copyWith(
                                color: appController.isDarkModeOn.value
                                    ? ColorConstants.lightAppBar
                                    : ColorConstants.darkBackground,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: getSize(64),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}

// ignore: must_be_immutable, camel_case_types
class _buildItemHistory extends GetView<RequestController> {
  TourModel? tourModel;
  HistoryModel? historyModel;
  UserModel? userModel;
  _buildItemHistory({
    required this.tourModel,
    required this.historyModel,
    required this.userModel,
  });

  HistoryTourController historyTourController =
      Get.put(HistoryTourController());

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.TOUR_REQUEST_DETAILS, arguments: {
          'arg1': tourModel,
          'arg2': historyModel,
          'arg3': userModel,
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorConstants.lightCard,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(getSize(8)),
              child: tourModel?.images != null && tourModel?.images != []
                  ? CachedNetworkImage(
                      height: getSize(200),
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
                    height: getSize(8),
                  ),
                  Text(
                    tourModel?.nameTour ?? '',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: AppStyles.black000Size16Fw500FfMont,
                  ),
                  SizedBox(
                    height: getSize(8),
                  ),
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
                        style: AppStyles.titleSearchSize16Fw400FfMont.copyWith(
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.dividerColor
                              : ColorConstants.botTitle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(8),
                  ),
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
                        style: AppStyles.titleSearchSize14Fw400FfMont.copyWith(
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.dividerColor
                              : ColorConstants.botTitle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
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
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.showAlertDialog(
                          context,
                          historyModel!,
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          ColorConstants.primaryButton,
                        ),
                      ),
                      child: Text("Approve"),
                    ),
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
