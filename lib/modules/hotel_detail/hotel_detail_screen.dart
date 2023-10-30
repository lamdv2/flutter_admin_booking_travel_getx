import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HotelDetailScreen extends StatefulWidget {
  const HotelDetailScreen({super.key});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: getSize(statusBarHeight),
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AssetHelper.hotel_1,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              height: getSize(224),
              padding: EdgeInsets.all(
                getSize(20),
              ),
              child: const HeaderWidget(),
            ),
            SizedBox(
              height: getSize(16),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstants.darkBackground,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: '2',
                            style: AppStyles.black000Size10Fw500FfMont,
                          ),
                          TextSpan(
                            text: '/',
                            style: AppStyles.black000Size10Fw500FfMont,
                          ),
                          TextSpan(
                            text: '12',
                            style: AppStyles.black000Size10Fw500FfMont,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getSize(8),
                  ),
                  Text(
                    "Muong Thanh Hotel",
                    style: AppStyles.black000Size20Fw500FfMont,
                  ),
                  SizedBox(
                    height: getSize(8),
                  ),
                  Row(
                    children: [
                      Text(
                        "Rating: 4.6",
                        style: AppStyles.black000Size14Fw400FfMont,
                      ),
                      SizedBox(
                        width: getSize(8),
                      ),
                      Image.asset(
                        AssetHelper.icoStar,
                        width: getSize(20),
                        height: getSize(20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  Divider(
                    color: ColorConstants.gray,
                    thickness: getSize(0.5),
                    indent: getSize(16),
                    endIndent: getSize(16),
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'Khayangan Resort merupakan sebuah ak omodasi penginapan yang sangat cocok bagi kamu yang suka dengan kesunyian. Lokasi yang jauh dari keramaian dan lalu lintas ...',
                          style: AppStyles.graySecondSize12Fw400FfMont,
                        ),
                        TextSpan(
                          text: 'Read More',
                          style: AppStyles.blue000Size12Fw400FfMont,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  Text(
                    "Scene preview",
                    style: AppStyles.black000Size16Fw500FfMont,
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(getSize(14)),
                          child: Image.asset(
                            AssetHelper.city_1,
                            height: getSize(106),
                            width: getSize(164),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: getSize(24),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(getSize(14)),
                          child: Image.asset(
                            AssetHelper.city_3,
                            height: getSize(106),
                            width: getSize(164),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: getSize(24),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(getSize(14)),
                          child: Image.asset(
                            AssetHelper.city_4,
                            height: getSize(106),
                            width: getSize(164),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: getSize(24),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(getSize(14)),
                          child: Image.asset(
                            AssetHelper.city_2,
                            height: getSize(106),
                            width: getSize(164),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  Text(
                    "Location",
                    style: AppStyles.black000Size16Fw500FfMont,
                  ),
                  SizedBox(
                    height: getSize(8),
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'Khayangan Resort merupakan sebuah ak omodasi penginapan yang sangat cocok bagi kamu yang suka dengan kesunyian. Lokasi yang jauh dari keramaian dan lalu lintas ...',
                          style: AppStyles.graySecondSize12Fw400FfMont,
                        ),
                        TextSpan(
                          text: 'Read More',
                          style: AppStyles.blue000Size12Fw400FfMont,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getSize(16),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(getSize(12)),
                    child: Image.asset(
                      AssetHelper.city_1,
                      height: getSize(240),
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: getSize(32),
                  ),

                  MyButton(
                    onTap: () {
                      Get.toNamed(Routes.ROOM);
                    },
                    textBtn: "Choose",
                    colorBgr: ColorConstants.secondButton,
                    widthSize: MediaQuery.of(context).size.width,
                  ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width,
                  //   height: getSize(36),
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(getSize(16)),
                  //     child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         alignment: Alignment.center,
                  //         backgroundColor: ColorConstants.blue,
                  //       ),
                  //       onPressed: () {
                  //         Get.toNamed(Routes.ROOM);
                  //       },
                  //       child: const Text("Choose"),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: getSize(32),
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
