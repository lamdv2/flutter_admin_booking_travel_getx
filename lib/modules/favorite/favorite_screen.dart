import 'dart:math';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/widgets/ListDestination.dart';

class FavotiteScreen extends StatefulWidget {
  const FavotiteScreen({super.key});

  @override
  State<FavotiteScreen> createState() => _FavotiteScreenState();
}

class _FavotiteScreenState extends State<FavotiteScreen> {
  final AppController appController = Get.find();
  List<String> widgetList = ['Geeks', 'for', 'Geeks'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(
      () => Scaffold(
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkBackground
            : ColorConstants.lightBackground,
        body: SafeArea(
          // đổ dữ liệu vào sau:
          // child: MasonryGridView.count(
          //   crossAxisCount: 2,
          //   mainAxisSpacing: 4,
          //   crossAxisSpacing: 4,
          //   itemCount: 12,
          //   itemBuilder: (context, index) {
          //     double randomItemHeight = 0;
          //     index % 2 == 0 ? randomItemHeight = 220 : randomItemHeight = 192;
          //     return Container(
          //       alignment: Alignment.center,
          //       margin: const EdgeInsets.all(4),
          //       child: DestinationItem(
          //         size: size,
          //         heightSize: randomItemHeight,
          //         textDes: index.toString(),
          //         img: AssetHelper.des1,
          //       ),
          //     );
          //   },
          // ),

          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    StringConst.favorite.tr,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ListDestination(size: size),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  double randomHeight() {
    var random = Random();
    return random.nextInt(2) == 0 ? 192 : 220;
  }
}
