import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/hotel_item_vertical.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/utils/size_utils.dart';
import '../../shared/widgets/stateful/hotel_item.dart';
import '../../shared/widgets/stateful/item_hot_hotel.dart';
import '../home/widgets/title_des.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({super.key});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appController.isDarkModeOn.value
          ? ColorConstants.darkBackground
          : ColorConstants.lightBackground,
      appBar: CustomAppBar(
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkAppBar
            : ColorConstants.primaryButton,
        iconBgrColor: ColorConstants.grayTextField,
        titles: StringConst.hotels.tr,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(getSize(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: getSize(8),
              ),
              SearchBarWidget(
                hintText: StringConst.searchHotel.tr,
              ),
              SizedBox(
                height: getSize(24),
              ),
              SizedBox(
                height: getSize(100),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ItemTopHotel(
                      nameHotel: 'Muong Thanh',
                      imgHotel: AssetHelper.city_1,
                    ),
                    SizedBox(
                      width: getSize(16),
                    ),
                    ItemTopHotel(
                      nameHotel: 'ABC',
                      imgHotel: AssetHelper.city_4,
                    ),
                    SizedBox(
                      width: getSize(16),
                    ),
                    ItemTopHotel(
                      nameHotel: 'Six Love',
                      imgHotel: AssetHelper.city_2,
                    ),
                    SizedBox(
                      width: getSize(16),
                    ),
                    ItemTopHotel(
                      nameHotel: 'Karim Town',
                      imgHotel: AssetHelper.city_3,
                    ),
                    SizedBox(
                      width: getSize(16),
                    ),
                    ItemTopHotel(
                      nameHotel: 'Thanh Thuy',
                      imgHotel: AssetHelper.city_6,
                    ),
                    SizedBox(
                      width: getSize(16),
                    ),
                    ItemTopHotel(
                      nameHotel: 'Hoa Hong',
                      imgHotel: AssetHelper.city_7,
                    ),
                    SizedBox(
                      width: getSize(16),
                    ),
                    ItemTopHotel(
                      nameHotel: 'KKV',
                      imgHotel: AssetHelper.city_8,
                    ),
                    SizedBox(
                      width: getSize(16),
                    ),
                    ItemTopHotel(
                      nameHotel: 'Novotel',
                      imgHotel: AssetHelper.city_5,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getSize(32),
              ),
              TitleDes(
                largeTitle: StringConst.result.tr,
                seeAll: StringConst.seeAll.tr,
                onTap: () => Get.toNamed(Routes.HOTEL_ALL),
              ),
              SizedBox(
                height: getSize(16),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    3,
                    (rowIndex) => Row(
                      children: [
                        if (rowIndex > 0)
                          SizedBox(
                            width: getSize(16),
                          ),
                        HotelItemWidget(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getSize(24),
              ),
              TitleDes(
                largeTitle: StringConst.nearByYourLocation.tr,
                seeAll: StringConst.seeAll.tr,
                onTap: () => Get.toNamed(Routes.HOTEL_ALL),
              ),
              SizedBox(
                height: getSize(16),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10, // Số lượng hàng bạn muốn tạo
                itemBuilder: (BuildContext context, int rowIndex) {
                  return Row(
                    children: [
                      if (rowIndex > 0)
                        SizedBox(
                          height: getSize(16),
                        ),
                      Expanded(
                        child: HotelItemVerticalWidget(),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: getSize(16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
