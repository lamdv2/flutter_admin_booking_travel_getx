import 'package:doan_clean_achitec/modules/home/widgets/title_des.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:doan_clean_achitec/shared/constants/dimension_constants.dart';
import 'package:doan_clean_achitec/shared/widgets/sevice_item_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/tour_sight_seeing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../shared/utils/size_utils.dart';

class DetailPlaceScreen extends StatefulWidget {
  const DetailPlaceScreen({super.key});

  @override
  State<DetailPlaceScreen> createState() => _DetailPlaceScreenState();
}

class _DetailPlaceScreenState extends State<DetailPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(getSize(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ho Chi Minh City",
                      style: TextStyle(
                          color: ColorConstants.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () => Get.back(),
                      borderRadius: BorderRadius.circular(kIconRadius),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 2,
                          top: 2,
                          bottom: 2,
                          right: 2,
                        ),
                        child: Container(
                          width: getSize(40),
                          height: getSize(40),
                          padding: EdgeInsets.all(getSize(kItemPadding)),
                          decoration: const BoxDecoration(
                            color: ColorConstants.grayTextField,
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
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  StringConst.letsExplore.tr,
                  style: TextStyle(
                      color: ColorConstants.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: getSize(16),
                ),
                SizedBox(
                  height: getSize(240),
                  child: Center(
                    child: Stack(
                      children: [
                        Positioned(
                          child: Container(
                            height: size.height / 3.5,
                            width: size.width,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                image: AssetImage(AssetHelper.city_bgr_1),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 24,
                          left: size.width / 3.3,
                          child: const Text(
                            "Fri, 22 May 2023",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 58,
                          left: size.width / 2.6,
                          child: Row(
                            children: [
                              Image.asset(
                                AssetHelper.icoSun,
                                color: ColorConstants.white,
                                width: getSize(24),
                                height: getSize(24),
                              ),
                              Text(
                                "  36",
                                style: TextStyle(
                                  fontSize: getSize(24),
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          // top: 180,
                          right: 0,
                          left: 0,
                          bottom: 0,
                          child: SizedBox(
                            height: size.height / 22,
                            width: size.width,
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      StringConst.wind.tr,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Text(
                                      "13 Km/h",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      StringConst.humidity.tr,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Text(
                                      "25",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      StringConst.visibility.tr,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Text(
                                      "10 Km",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      StringConst.pressure.tr,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Text(
                                      "1010 mb",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getSize(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SeviceItemWidget(
                      onTap: (GetSnackBar snack) {
                        Get.toNamed(Routes.HOTEL);
                      },
                      icon: AssetHelper.icWallet,
                      seviceTitle: StringConst.tours.tr,
                      isCheckActive: true,
                    ),
                    SeviceItemWidget(
                      onTap: (snack) {
                        Get.toNamed(Routes.HOTEL);
                      },
                      icon: AssetHelper.icoHotel,
                      seviceTitle: StringConst.hotels.tr,
                      isCheckActive: false,
                    ),
                    SeviceItemWidget(
                      onTap: (GetSnackBar snack) {
                        Get.toNamed(Routes.HOTEL);
                      },
                      icon: AssetHelper.icoPlane,
                      seviceTitle: StringConst.flights.tr,
                      isCheckActive: false,
                    ),
                    SeviceItemWidget(
                      onTap: (GetSnackBar snack) {
                        Get.toNamed(Routes.HOTEL);
                      },
                      icon: AssetHelper.icoRestau,
                      seviceTitle: StringConst.restaurants.tr,
                      isCheckActive: false,
                    ),
                  ],
                ),
                SizedBox(
                  height: getSize(28),
                ),
                TitleDes(
                  largeTitle: StringConst.sightseeing.tr,
                  seeAll: StringConst.seeAll.tr,
                  onTap: () {
                    Get.toNamed(Routes.TOUR);
                  },
                ),
                SizedBox(
                  height: getSize(16),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TourSightSeeingWidget(
                        nameImage: AssetHelper.city_7,
                      ),
                      SizedBox(
                        width: getSize(16),
                      ),
                      TourSightSeeingWidget(
                        nameImage: AssetHelper.city_8,
                      ),
                      SizedBox(
                        width: getSize(16),
                      ),
                      TourSightSeeingWidget(
                        nameImage: AssetHelper.city_6,
                      ),
                      SizedBox(
                        width: getSize(16),
                      ),
                      TourSightSeeingWidget(
                        nameImage: AssetHelper.city_5,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getSize(28),
                ),
                Text(
                  StringConst.topPickArticles.tr,
                  style: AppStyles.black000Size18Fw500FfMont,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        height: size.height / 5,
                        width: size.width / 3 * 2,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(AssetHelper.city_3),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 16, left: 16, bottom: 16),
                        height: size.height / 5,
                        width: size.width / 3 * 2,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(AssetHelper.city_1),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(16),
                        height: size.height / 5,
                        width: size.width / 3 * 2,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage(AssetHelper.city_2),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ],
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
