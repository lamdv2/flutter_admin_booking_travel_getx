import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class TourSightSeeingWidget extends StatelessWidget {
  String nameImage;

  TourSightSeeingWidget({
    required this.nameImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getSize(320),
      width: getSize(200),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(nameImage),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      alignment: Alignment.bottomLeft,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: IntrinsicHeight(
          child: Container(
            // height: getSize(100),

            padding: EdgeInsets.all(
              getSize(16),
            ),
            decoration: BoxDecoration(
              color: ColorConstants.titleSearch.withOpacity(.4),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  'Madeira',
                  style: AppStyles.white000Size13FfMont
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: getFontSize(8),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      AssetHelper.icoMaps,
                      colorFilter: const ColorFilter.mode(
                        ColorConstants.btnCanCel,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(
                      width: getFontSize(8),
                    ),
                    Text(
                      'Portugal',
                      style: AppStyles.white000Size12Fw400FfMont,
                    ),
                  ],
                ),
                SizedBox(
                  height: getFontSize(8),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$123',
                      style: AppStyles.white000Size14Fw400FfMont,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AssetHelper.icoStarSvg,
                          width: getSize(16),
                          colorFilter: const ColorFilter.mode(
                            ColorConstants.yellow,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(
                          width: getFontSize(8),
                        ),
                        Text(
                          '4.5',
                          style: AppStyles.white000Size13FfMont,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
