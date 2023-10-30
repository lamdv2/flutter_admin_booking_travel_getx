import 'package:carousel_slider/carousel_slider.dart';
import 'package:doan_clean_achitec/models/Destination.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/widgets/stateless/list_star_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../../../shared/constants/app_style.dart';
import '../../../shared/constants/dimension_constants.dart';

class CarouselSliderDes extends StatefulWidget {
  const CarouselSliderDes({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<CarouselSliderDes> createState() => _CarouselSliderDesState();
}

class _CarouselSliderDesState extends State<CarouselSliderDes> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          initialPage: 0,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
          viewportFraction: 0.7,
        ),
        items: destiList.map((desList) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.DETAIL_PLACE);
                },
                child: Stack(
                  children: [
                    Container(
                      width: widget.size.width,
                      height: widget.size.height,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: ColorConstants.lightBlueNon,
                        borderRadius: kBigBorderRadius,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(desList.imgDes.toString()),
                        ),
                      ),
                    ),
                    Container(
                      height: widget.size.height,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Gradients.darkGreyNon,
                            Gradients.darkGreyMid,
                            Gradients.darkGrey,
                          ],
                        ),
                        borderRadius: kBigBorderRadius,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  left: kTopPadding,
                                  bottom: kTopPadding,
                                ),
                                child: Text(
                                  desList.nameDes.toString(),
                                  style: AppStyles.white000Size18FfMont,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: kTopPadding,
                                  bottom: kTopPadding,
                                ),
                                margin: const EdgeInsets.only(
                                    bottom: kDefaultPadding),
                                child: ListStarWidget(desti: desList),
                              ),
                            ],
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            padding: const EdgeInsets.only(
                              right: kMinPadding,
                              bottom: kTop36Padding,
                            ),
                            child: LikeButton(
                              onTap: (isLiked) async {
                                setState(() {
                                  desList.isFavorite = !desList.isFavorite;
                                });
                                return Future.value(!isLiked);
                              },
                              isLiked: desList.isFavorite,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              size: 40,
                              circleColor: const CircleColor(
                                  start: Color(0xff00ddff),
                                  end: Color(0xff0099cc)),
                              bubblesColor: const BubblesColor(
                                dotPrimaryColor: Color(0xff33b5e5),
                                dotSecondaryColor: Color(0xff0099cc),
                              ),
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  FontAwesomeIcons.solidHeart,
                                  color: isLiked ? Colors.red : Colors.white,
                                  size: 24,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
