import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../../constants/app_style.dart';

class HotelItemVerticalWidget extends StatelessWidget {
  HotelItemVerticalWidget({
    super.key,
  });

  final AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    bool isFavor = false;
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.ROOM),
      child: Container(
        width: MediaQuery.of(context).size.width - getSize(40),
        decoration: BoxDecoration(
          color: appController.isDarkModeOn.value
              ? ColorConstants.darkCard
              : ColorConstants.lightCard,
          borderRadius: BorderRadius.circular(getSize(14)),
        ),
        margin: EdgeInsets.only(bottom: getSize(16)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(getSize(12)),
                        child: Image.asset(
                          AssetHelper.imgPrevHotel01,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: getSize(24),
                        height: getSize(24),
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
                          size: 12,
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
                              size: 14,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: getSize(16),
              ),
              Expanded(
                flex: 5,
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
                            text: "  Purwokerto, Jateng",
                            style: AppStyles.botTitle000Size14Fw400FfMont,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getSize(4),
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
                          style: AppStyles.botTitle000Size14Fw400FfMont,
                        ),
                        SizedBox(
                          width: getSize(8.0),
                        ),
                        Text(
                          "(3241 reviews)",
                          style: AppStyles.graySecondSize14Fw400FfMont,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getSize(4),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "\$143",
                            style: TextStyle(
                              color: ColorConstants.botTitle,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: "/night",
                            style: AppStyles.botTitle000Size14Fw400FfMont,
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
      ),
    );
  }
}
