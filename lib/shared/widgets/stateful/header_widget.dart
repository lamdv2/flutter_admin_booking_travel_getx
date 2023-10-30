import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/size_utils.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({
    super.key,
    this.titleHeader,
    this.trailing,
    this.onTap,
    this.imageIcon,
    this.colorIcon,
  });

  final String? titleHeader;
  final bool? trailing;
  final OnTap? onTap;
  final String? imageIcon;
  final Color? colorIcon;

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Get.back();
          },
          splashColor: ColorConstants.titleSearch,
          radius: getSize(20),
          child: Container(
            width: getSize(36),
            height: getSize(36),
            decoration: BoxDecoration(
              color: ColorConstants.white,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  getSize(kIconRadius),
                ),
              ),
            ),
            padding: EdgeInsets.all(getSize(8.0)),
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
        widget.titleHeader != null
            ? Expanded(
                child: Center(
                  child: Text(
                    "${widget.titleHeader}",
                    style: AppStyles.black000Size30Fw600FfMont,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        widget.trailing != null
            ? Container(
                width: getSize(36),
                height: getSize(36),
                decoration: BoxDecoration(
                  color: ColorConstants.white,
                  borderRadius: BorderRadius.circular(kIconRadius),
                ),
                padding: EdgeInsets.all(getSize(8.0)),
                child: InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Image.asset(
                    widget.imageIcon ?? AssetHelper.heart,
                    color: widget.colorIcon ?? ColorConstants.red,
                  ),
                ),
              )
            : SizedBox(width: getSize(32)),
      ],
    );
  }
}
