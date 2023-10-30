import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/home/home_screen.dart';
import 'package:doan_clean_achitec/modules/home/widgets/home_header.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/widgets/ListDestination.dart';
import '../home/widgets/title_des.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Obx(
      () => Scaffold(
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkBackground
            : ColorConstants.lightBackground,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                HomeHeader(
                  size: size,
                  titleCenter: StringConst.discover.tr,
                ),
                SizedBox(
                  height: getSize(16),
                ),
                SearchBarWidget(hintText: StringConst.searchDestinations.tr),
                SizedBox(
                  height: getSize(32),
                ),
                TitleDes(
                  largeTitle: StringConst.popularDestination.tr,
                  seeAll: StringConst.seeAll.tr,
                  onTap: () => homeController.currentIndex.value = 0,
                ),
                ListDestination(size: size),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
