import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/models/city/city_model.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/employee/tab_employee/search_controller.dart';
import 'package:doan_clean_achitec/modules/tour/tour.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:doan_clean_achitec/shared/widgets/stateless/star_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class TabEmployeeWidget extends GetView<TabEmployeeController> {
  TabEmployeeWidget({super.key});

  final AppController appController = Get.find();
  final TourController tourController = Get.find();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkBackground
            : ColorConstants.lightBackground,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TabBar(
                      isScrollable: true,
                      labelColor: appController.isDarkModeOn.value
                          ? ColorConstants.primaryButton
                          : ColorConstants.primaryButton,
                      unselectedLabelColor: ColorConstants.gray,
                      indicatorColor: appController.isDarkModeOn.value
                          ? ColorConstants.primaryButton
                          : ColorConstants.primaryButton,
                      tabs: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Tab(text: 'Popular destination'),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Tab(text: 'Current tour'),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Tab(text: 'Current destination'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Obx(
                  () => TabBarView(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(getSize(4.0)),
                        child: buildContentTab1(context),
                      ),
                      Padding(
                        padding: EdgeInsets.all(getSize(4.0)),
                        child: buildContentTab2(context),
                      ),
                      Padding(
                        padding: EdgeInsets.all(getSize(4.0)),
                        child: buildContentTab3(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContentTab1(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: getSize(20)),
          SizedBox(
            height: getSize(200),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: tourController.getListTour.value != null &&
                      tourController.getListTour.value!.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tourController.getListTour.value?.length ?? 0,
                      itemBuilder: (BuildContext context, int rowIndex) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (rowIndex > 0)
                              SizedBox(
                                width: getSize(16),
                              ),
                            ItemTourSearch(
                              tourModel:
                                  tourController.getListTour.value![rowIndex],
                            ),
                          ],
                        );
                      },
                    )
                  : Lottie.asset(
                      AssetHelper.imgLottieNodate,
                      width: getSize(200),
                      height: getSize(200),
                      fit: BoxFit.fill,
                    ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(getSize(20)),
              color: Theme.of(context).cardColor,
            ),
            child: Padding(
              padding: EdgeInsets.all(getSize(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  true
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 0,
                          itemBuilder: (BuildContext context, int rowIndex) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (rowIndex > 0)
                                  SizedBox(
                                    height: getSize(16),
                                  ),
                                // ItemSearchDes(
                                //   cityModel:
                                //       controller.listCitys.value[rowIndex],
                                // ),
                              ],
                            );
                          },
                        )
                      : Lottie.asset(
                          AssetHelper.imgLottieNodate,
                          width: getSize(200),
                          height: getSize(200),
                          fit: BoxFit.fill,
                        ),
                ],
              ),
            ),
          ),
          SizedBox(height: getSize(16)),
        ],
      ),
    );
  }

  Widget buildContentTab2(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: getSize(20)),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(getSize(20)),
            color: Theme.of(context).cardColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(getSize(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // controller.
                // getListHistoryCurrentTour.value != null &&
                //         controller.getListHistoryCurrentTour.value!.isNotEmpty
                //     ?
                true
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            // controller
                            //         .getListHistoryCurrentTour.value?.length ??
                            0,
                        itemBuilder: (BuildContext context, int rowIndex) {
                          // final reversedList = controller
                          //     .getListHistoryCurrentTour.value?.reversed
                          //     .toList();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (rowIndex > 0)
                                SizedBox(
                                  width: getSize(10),
                                ),
                              // ItemTourSearch(
                              //   height: MediaQuery.of(context).size.width -
                              //       getSize(120),
                              //   width: double.infinity,
                              //   space: 8,
                              //   tourModel: reversedList![rowIndex],
                              // ),
                            ],
                          );
                        },
                      )
                    : Lottie.asset(
                        AssetHelper.imgLottieNodate,
                        width: getSize(200),
                        height: getSize(200),
                        fit: BoxFit.fill,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContentTab3(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: getSize(20)),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(getSize(20)),
            color: Theme.of(context).cardColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(getSize(24)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // controller.getListHistoryCurrentDes.value != null &&
                //         controller.getListHistoryCurrentDes.value!.isNotEmpty
                true
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            // controller.getListHistoryCurrentDes.value?.length ??
                            0,
                        itemBuilder: (BuildContext context, int rowIndex) {
                          // final reversedList = controller
                          //     .getListHistoryCurrentDes.value?.reversed
                          //     .toList();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (rowIndex > 0) SizedBox(height: getSize(16)),
                              // Row(
                              //   children: [
                              //     ClipRRect(
                              //       borderRadius:
                              //           BorderRadius.circular(getSize(8)),
                              //       child: reversedList?[rowIndex].imageCity !=
                              //                   null &&
                              //               reversedList![rowIndex]
                              //                   .imageCity!
                              //                   .isNotEmpty
                              //           ? CachedNetworkImage(
                              //               height: getSize(84),
                              //               width: getSize(84),
                              //               fit: BoxFit.cover,
                              //               imageUrl: reversedList[rowIndex]
                              //                   .imageCity!,
                              //             )
                              //           : Image.asset(
                              //               height: getSize(84),
                              //               width: getSize(84),
                              //               AssetHelper.imgPrevHotel01,
                              //               fit: BoxFit.cover,
                              //             ),
                              //     ),
                              //     SizedBox(width: getSize(24)),
                              //     Text(
                              //       reversedList?[rowIndex].nameCity ?? '',
                              //       style: AppStyles.black000Size14Fw400FfMont,
                              //     ),
                              //   ],
                              // ),
                            ],
                          );
                        },
                      )
                    : Lottie.asset(
                        AssetHelper.imgLottieNodate,
                        width: getSize(200),
                        height: getSize(200),
                        fit: BoxFit.fill,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemSearchDes extends StatelessWidget {
  ItemSearchDes({
    super.key,
    required this.cityModel,
  });

  final CityModel cityModel;
  // final SearchDesController searchDesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // await searchDesController.setHistoryCurrentDestination(cityModel);
        // await searchDesController.getHistoryCurrentDestination();
        Get.toNamed(
          Routes.DETAIL_PLACE,
          arguments: cityModel,
        );
      },
      child: Container(
        color: ColorConstants.transparent,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                getSize(8),
              ),
              child:
                  cityModel.imageCity != null && cityModel.imageCity!.isNotEmpty
                      ? CachedNetworkImage(
                          height: getSize(84),
                          width: getSize(84),
                          fit: BoxFit.cover,
                          imageUrl: cityModel.imageCity ?? '',
                        )
                      : Image.asset(
                          height: getSize(84),
                          width: getSize(84),
                          AssetHelper.imgPrevHotel01,
                          fit: BoxFit.cover,
                        ),
            ),
            SizedBox(
              width: getSize(24),
            ),
            Text(
              cityModel.nameCity,
              style: AppStyles.black000Size14Fw400FfMont,
            ),
          ],
        ),
      ),
    );
  }
}

class ItemTourSearch extends StatelessWidget {
  ItemTourSearch({
    super.key,
    required this.tourModel,
    this.height,
    this.width,
    this.space,
  });

  final TourModel tourModel;
  final double? height;
  final double? width;
  final double? space;

  // final SearchDesController searchDesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (tourModel.active) {
          // await searchDesController.setHistoryCurrentTour(tourModel);
          // await searchDesController.getHistoryCurrentTour();
          Get.toNamed(
            Routes.TOUR_DETAILS,
            arguments: tourModel,
          );
        } else {
          Get.snackbar("Notification", "The tour is on hold!");
        }
      },
      child: SizedBox(
        height: height ?? getSize(180),
        width: width ?? getSize(180),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(getSize(16)),
                    child: tourModel.images != null && tourModel.images != []
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: tourModel.images?.first ?? '',
                          )
                        : Image.asset(
                            AssetHelper.imgPrevHotel01,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                tourModel.active
                    ? const SizedBox.shrink()
                    : Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.all(getSize(8)),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.white.withOpacity(.8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.all(getSize(8)),
                            child: Text(
                              "Temporarily stopped",
                              style: AppStyles.blue000Size12Fw400FfMont,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: getSize(10),
            ),
            Text(
              tourModel.nameTour,
              style: AppStyles.black000Size14Fw400FfMont,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: getSize(space ?? 4),
            ),
            Row(
              children: [
                const StarWidget(),
                SizedBox(
                  width: getSize(4),
                ),
                Text(
                  tourModel.rating.toString(),
                ),
              ],
            ),
            SizedBox(
              height: getSize(space ?? 4),
            ),
            Text(
              tourModel.price.toString(),
              style: AppStyles.blue000Size14Fw400FfMont,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
