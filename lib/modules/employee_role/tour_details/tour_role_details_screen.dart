import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/employee_role/tour_details/tour_role_controller.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:doan_clean_achitec/shared/widgets/image_full_screen_all.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:doan_clean_achitec/shared/widgets/item_utility_detail_hotel_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/stateless/dash_widget.dart';
import 'package:lottie/lottie.dart';

class TourRoleDetailsScreen extends StatelessWidget {
  TourRoleDetailsScreen({Key? key}) : super(key: key);
  final TourRoleController tourRoleController = Get.put(TourRoleController());
  final TourModel? tourModel = Get.arguments;
  final AppController appController = Get.find();
  final int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appController.isDarkModeOn.value
          ? ColorConstants.darkBackground
          : ColorConstants.lightBackground,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned.fill(
            child: tourModel?.images != null && tourModel?.images != []
                ? GestureDetector(
                    onTap: () => Get.to(
                      FullImageScreenAll(
                        imageUrl: tourModel?.images?.first ?? '',
                        isCheckNetwork: true,
                      ),
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: tourModel!.images?.isNotEmpty == true
                          ? tourModel!.images!.first
                          : 'https://firebasestorage.googleapis.com/v0/b/doan-final-travel.appspot.com/o/assets%2Fsystem%2Fic_nodata.png?alt=media&token=51128304-2989-4d9e-84b2-81155f0d06f8',
                    ),
                  )
                : GestureDetector(
                    onTap: () => Get.to(
                      FullImageScreenAll(
                        imageUrl: AssetHelper.des8,
                        isCheckNetwork: false,
                      ),
                    ),
                    child: Image.asset(
                      AssetHelper.des8,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          Positioned(
            top: getSize(kMediumPadding * 2),
            left: getSize(kPadding),
            child: InkWell(
              onTap: () => Get.back(),
              child: _buildBackButton(),
            ),
          ),
          Positioned(
            top: kMediumPadding * 2,
            right: kPadding,
            child: InkWell(
              onTap: () async {
                Get.toNamed(
                  Routes.USER_IN_TOUR,
                  arguments: tourModel,
                );
              },
              child: _buildFavoriteButton(),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            maxChildSize: 0.85,
            minChildSize: 0.4,
            builder: (context, scrollController) {
              return Container(
                padding:
                    EdgeInsets.symmetric(horizontal: getSize(kMediumPadding)),
                decoration: BoxDecoration(
                  color: appController.isDarkModeOn.value
                      ? ColorConstants.darkBackground
                      : ColorConstants.lightBackground,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(kDefaultPadding * 2),
                    topRight: Radius.circular(kDefaultPadding * 2),
                  ),
                ),
                child: Column(
                  children: [
                    _buildDragIndicator(),
                    SizedBox(height: getSize(kDefaultPadding)),
                    Flexible(
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: [
                          _buildTourInfo(tourModel, tourRoleController),
                          SizedBox(height: getSize(kTopPadding)),
                          const DashLineWidget(),
                          SizedBox(height: getSize(kTopPadding)),
                          _buildTourRating(),
                          SizedBox(height: getSize(kItemPadding)),
                          _buildTourDescription(tourModel),
                          SizedBox(height: getSize(kDefaultPadding)),
                          _buildTourUtilities(),
                          SizedBox(height: getSize(kPadding)),
                          _buildTripPlan(tourModel),
                          _buildLocation(tourRoleController),
                          _buildPhotoGallery(tourModel),
                          SizedBox(height: getSize(kMediumPadding)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> showDialogAddEmpl(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        content: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -40,
                  top: -40,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      tourRoleController.setInit();
                    },
                    child: const CircleAvatar(
                      backgroundColor: ColorConstants.red,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: SearchBarWidget(
                          textEditingController:
                              tourRoleController.searchEmployeeController,
                          hintText: "Search your employee",
                          borderColor: ColorConstants.accent2,
                          onChanged: (value) =>
                              tourRoleController.searchEmployee(value),
                        ),
                      ),
                      Obx(
                        () => tourRoleController.listAllEmployee.value !=
                                    null &&
                                tourRoleController
                                    .listAllEmployee.value!.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: tourRoleController
                                        .listAllEmployee.value?.length ??
                                    0,
                                itemBuilder: (
                                  BuildContext context,
                                  int rowIndex,
                                ) {
                                  return ListTile(
                                    leading: tourRoleController.listAllEmployee
                                                .value?[rowIndex].imgAvatar !=
                                            ""
                                        ? CircleAvatar(
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                              tourRoleController
                                                      .listAllEmployee
                                                      .value?[rowIndex]
                                                      .imgAvatar ??
                                                  "",
                                            ),
                                          )
                                        : CircleAvatar(
                                            child: SvgPicture.asset(
                                              AssetHelper.icAddUser,
                                            ),
                                          ),
                                    title: Text(
                                      "${tourRoleController.listAllEmployee.value?[rowIndex].email}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          AppStyles.black000Size14Fw400FfMont,
                                    ),
                                    trailing: Obx(
                                      () => Checkbox(
                                        value: tourRoleController
                                            .checkBoxStates[rowIndex],
                                        onChanged: (bool? value) {
                                          tourRoleController
                                              .toggleCheckBox(rowIndex);
                                        },
                                        activeColor:
                                            ColorConstants.primaryButton,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Lottie.asset(
                                  AssetHelper.imgLottieNodate,
                                  width: getSize(200),
                                  height: getSize(200),
                                  fit: BoxFit.fill,
                                ),
                              ),
                      ),
                      SizedBox(
                        height: getSize(40),
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: -20,
                  child: InkResponse(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () {
                          Get.back();
                          tourRoleController
                              .setEmployee(tourModel?.idTour ?? "");
                          tourRoleController.setInit();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      height: getSize(36),
      width: getSize(36),
      padding: EdgeInsets.all(getSize(kItemPadding)),
      decoration: const BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.all(
          Radius.circular(kIconRadius),
        ),
      ),
      child: SvgPicture.asset(
        AssetHelper.icoNextLeft,
        colorFilter: const ColorFilter.mode(
          ColorConstants.titleSearch,
          BlendMode.srcIn,
        ),
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return Container(
      height: getSize(36),
      width: getSize(36),
      padding: EdgeInsets.all(getSize(kItemPadding)),
      decoration: const BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.all(
          Radius.circular(kIconRadius),
        ),
      ),
      child: SvgPicture.asset(
        AssetHelper.icUser3,
        colorFilter: const ColorFilter.mode(
          ColorConstants.titleSearch,
          BlendMode.srcIn,
        ),
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _buildDragIndicator() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: kDefaultPadding),
      child: Container(
        height: 5,
        width: 60,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(kDefaultPadding),
          ),
        ),
      ),
    );
  }

  Widget _buildTourInfo(
      TourModel? tourModel, TourRoleController tourRoleController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tourModel?.nameTour ?? '',
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: appController.isDarkModeOn.value
                  ? ColorConstants.lightBackground
                  : ColorConstants.darkBackground),
        ),
        SizedBox(height: getSize(kPadding)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AssetHelper.icLocation,
                  width: getSize(kPadding),
                ),
                SizedBox(width: getSize(kItemPadding)),
                Obx(
                  () => Text(
                    tourRoleController.getNameCityById(tourModel?.idCity ?? ''),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '${tourModel?.price?.toInt()}đ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.lightBackground
                        : ColorConstants.botTitle,
                  ),
                ),
                Text(
                  StringConst.night.tr,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTourRating() {
    return Row(
      children: [
        ImageHelper.loadFromAsset(
          AssetHelper.icoStar,
          width: getSize(kTop32Padding),
          boxFit: BoxFit.fitWidth,
        ),
        SizedBox(width: getSize(kTopPadding)),
        Text(
          '${tourModel?.rating}${StringConst.five.tr} ',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          '(${tourModel?.reviews?.toInt()} ${StringConst.review.tr})',
          style: TextStyle(
            fontSize: 16,
            color: appController.isDarkModeOn.value
                ? Colors.grey[300]
                : Colors.blueGrey.shade500,
          ),
        ),
        const Spacer(),
        Text(
          StringConst.seeAll.tr,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorConstants.primaryButton,
          ),
        ),
      ],
    );
  }

  Widget _buildTourDescription(TourModel? tourModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Description",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: getSize(kDefaultPadding)),
        Text(
          tourModel?.description ?? '',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildTourUtilities() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ItemUtilityDetailHotelWidget(),
    );
  }

  Widget _buildTripPlan(TourModel? tourModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringConst.tripPlan.tr,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tourModel?.itinerary?.length ?? 0,
          itemBuilder: (BuildContext context, int rowIndex) {
            String itinerary = tourModel!.itinerary![rowIndex];
            List<String> parts = itinerary.split('/');
            String titleTourDay = parts[0].trim();
            String description = parts.length > 1 ? parts[1].trim() : '';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (rowIndex > 0) SizedBox(height: getSize(20)),
                Text(
                  titleTourDay,
                  style: AppStyles.black000Size16Fw500FfMont.copyWith(
                    color: appController.isDarkModeOn.value
                        ? ColorConstants.lightBackground
                        : ColorConstants.black,
                  ),
                ),
                SizedBox(height: getSize(12)),
                if (description.isNotEmpty)
                  Text(
                    description,
                    style: AppStyles.black000Size14Fw400FfMont.copyWith(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.lightBackground
                          : ColorConstants.black,
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildPhotoGallery(TourModel? tourModel) {
    return tourModel?.images != null && tourModel?.images != []
        ? SizedBox(
            child: GridView.builder(
              itemCount: tourModel?.images?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    right: 12,
                    bottom: 12,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      getSize(8),
                    ),
                    child: GestureDetector(
                      onTap: () => tourRoleController.showFullImageDialog(
                          context, tourModel?.images?[index] ?? ''),
                      child: SizedBox(
                        width: 64,
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: tourModel?.images?[index] ?? '',
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : SizedBox(
            width: getSize(240),
            height: getSize(240),
            child: Lottie.asset(
              AssetHelper.imgLottieNodate,
              fit: BoxFit.contain,
            ),
          );
  }

  Widget _buildLocation(TourRoleController tourRoleController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              StringConst.location.tr,
              style: AppStyles.black000Size18Fw600FfMont,
            ),
            GestureDetector(
              onTap: () =>
                  tourRoleController.launchMap(tourModel?.location ?? ''),
              child: Text(
                StringConst.showMap.tr,
                style: AppStyles.blue000Size16Fw400FfMont,
              ),
            )
          ],
        ),
      ],
    );
  }
}
