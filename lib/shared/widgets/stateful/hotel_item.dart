import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../../constants/app_style.dart';

class HotelItemWidget extends StatelessWidget {
  HotelItemWidget({
    super.key,
  });

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    bool isFavor = false;
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.ROOM),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        decoration: BoxDecoration(
          color: appController.isDarkModeOn.value
              ? ColorConstants.darkCard
              : ColorConstants.grayTextField,
          borderRadius: BorderRadius.circular(getSize(14)),
        ),
        margin: EdgeInsets.only(bottom: getSize(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(getSize(12)),
                child: Image.asset(
                  AssetHelper.imgPrevHotel01,
                  height: getSize(140),
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: getSize(6),
                right: getSize(6),
                child: Container(
                  width: getSize(36),
                  height: getSize(36),
                  margin: EdgeInsets.all(getSize(4)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(getSize(8)),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  child: LikeButton(
                    onTap: (isLiked) async {
                      // setState(() {
                      //   isFavor = !isFavor;
                      // });
                      return Future.value(!isLiked);
                    },
                    isLiked: isFavor,
                    size: 15,
                    circleSize: 36,
                    mainAxisAlignment: MainAxisAlignment.center,
                    circleColor: const CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        FontAwesomeIcons.solidHeart,
                        color: isLiked ? Colors.red : Colors.white,
                        size: 18,
                      );
                    },
                  ),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getSize(20),
                vertical: getSize(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Royal Palm Heritage",
                    style: AppStyles.botTitle000Size20Fw500FfMont.copyWith(
                      color: appController.isDarkModeOn.value
                          ? ColorConstants.lightBackground
                          : ColorConstants.botTitle,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  SizedBox(
                    height: getSize(8.0),
                  ),
                  RichText(
                    softWrap: true,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: SvgPicture.asset(AssetHelper.icoMaps),
                          alignment: PlaceholderAlignment.middle,
                        ),
                        TextSpan(
                          text: "  Purwokerto, Jateng - ",
                          style:
                              AppStyles.botTitle000Size14Fw400FfMont.copyWith(
                            color: appController.isDarkModeOn.value
                                ? ColorConstants.lightBackground
                                : ColorConstants.botTitle,
                          ),
                        ),
                        TextSpan(
                          text: "364 m from destination",
                          style:
                              AppStyles.titleSearchSize12Fw400FfMont.copyWith(
                            color: appController.isDarkModeOn.value
                                ? ColorConstants.lightBackground
                                : ColorConstants.titleSearch,
                          ),
                        ),
                      ],
                      style: DefaultTextStyle.of(context).style.copyWith(
                            height: 1.4,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: getSize(8),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetHelper.icoStarSvg,
                      ),
                      SizedBox(
                        width: getSize(8.0),
                      ),
                      Text(
                        "4.5",
                        style: AppStyles.botTitle000Size14Fw400FfMont.copyWith(
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.gray
                              : ColorConstants.botTitle,
                        ),
                      ),
                      SizedBox(
                        width: getSize(8.0),
                      ),
                      Text(
                        "(3241 reviews)",
                        style: AppStyles.graySecondSize14Fw400FfMont.copyWith(
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.gray
                              : ColorConstants.graySecond,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(8),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "\$143",
                          style: TextStyle(
                            color: appController.isDarkModeOn.value
                                ? ColorConstants.lightBackground
                                : ColorConstants.botTitle,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: StringConst.night.tr,
                          style:
                              AppStyles.botTitle000Size14Fw400FfMont.copyWith(
                            color: appController.isDarkModeOn.value
                                ? ColorConstants.lightBackground
                                : ColorConstants.botTitle,
                          ),
                        ),
                      ],
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
