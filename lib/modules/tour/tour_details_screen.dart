import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:doan_clean_achitec/shared/widgets/image_full_screen_all.dart';
import 'package:doan_clean_achitec/shared/widgets/stateless/google_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/tour/tour.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:doan_clean_achitec/shared/widgets/item_utility_detail_hotel_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/stateless/dash_widget.dart';
import 'package:lottie/lottie.dart';

class TourDetailsScreen extends StatelessWidget {
  TourDetailsScreen({Key? key}) : super(key: key);
  final TourController tourController = Get.find();
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
                      imageUrl: tourModel?.images?.first ?? '',
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
            child: _buildFavoriteButton(),
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
                          _buildTourInfo(tourModel, tourController),
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
                          _buildPhotoGallery(tourModel),
                          SizedBox(height: getSize(kTop28Padding)),
                          _buildLocation(tourController),
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
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(getSize(kItemPadding)),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(kDefaultPadding)),
        ),
        child: const Icon(
          FontAwesomeIcons.heart,
          color: Colors.red,
        ),
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

  Widget _buildTourInfo(TourModel? tourModel, TourController tourController) {
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
                  AssetHelper.icoDestination,
                  width: getSize(kPadding),
                ),
                SizedBox(width: getSize(kItemPadding)),
                Obx(
                  () => Text(
                    tourController.getNameCityById(tourModel?.idCity ?? ''),
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
                  '\$${tourModel?.price.toString()}',
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
          '(${tourModel?.reviews?.length} ${StringConst.review.tr})',
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
        Text(
          StringConst.information.tr,
          style: const TextStyle(
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
                      onTap: () => tourController.showFullImageDialog(
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

  Widget _buildLocation(TourController tourController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              StringConst.location.tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            GestureDetector(
              onTap: () =>
                  tourController.launchMap(tourModel?.description ?? ''),
              child: Text(
                StringConst.showMap.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
        SizedBox(height: getSize(kDefaultPadding)),
        Text(
          tourController.cityModel.value?.descriptionCity ?? '',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: getSize(kDefaultPadding)),
        GestureDetector(
          onDoubleTap: () {
            Get.toNamed(Routes.GOOGLE_MAP_SCREEN);
          },
          child: const GoogleMapWidget(),
        ),
        SizedBox(height: getSize(kMediumPadding)),
      ],
    );
  }
}
