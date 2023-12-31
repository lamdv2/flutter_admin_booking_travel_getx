import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/admin/admin_controller.dart';
import 'package:doan_clean_achitec/modules/tour/tour_controller.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../../models/employee/employee.dart';

// ignore: must_be_immutable
class TourAdminItemWidget extends GetView<AdminController> {
  TourModel listTour;
  Function()? onTap;
  TourAdminItemWidget({
    required this.listTour,
    this.onTap,
    super.key,
  });

  TourController tourController = Get.put(TourController());
  AppController appController = Get.find();

  final listEmployeeOfTour = Rxn<List<EmployeeModel>>([]);
  void getData() async {
    listEmployeeOfTour.value =
        await controller.getListEmployee(listTour.idTour ?? "");
  }

  @override
  Widget build(BuildContext context) {
    getData();
    bool isFavor = false;
    return GestureDetector(
      onTap:
          onTap ?? () => Get.toNamed(Routes.TOUR_DETAILS, arguments: listTour),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: appController.isDarkModeOn.value
              ? ColorConstants.darkCard
              : ColorConstants.white,
          borderRadius: BorderRadius.circular(getSize(16)),
          border: Border.all(
            color: appController.isDarkModeOn.value
                ? ColorConstants.darkCard.withOpacity(.4)
                : ColorConstants.dividerColor.withOpacity(.4),
            width: 2,
          ),
        ),
        margin: EdgeInsets.only(bottom: getSize(20)),
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
                      borderRadius: BorderRadius.circular(getSize(16)),
                      child: listTour.images != null && listTour.images != []
                          ? CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: listTour.images?.isNotEmpty == true
                                  ? listTour.images!.first
                                  : 'https://firebasestorage.googleapis.com/v0/b/doan-final-travel.appspot.com/o/assets%2Fsystem%2Fic_nodata.png?alt=media&token=51128304-2989-4d9e-84b2-81155f0d06f8',
                            )
                          : Image.asset(
                              AssetHelper.imgPrevHotel01,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
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
                  listTour.active
                      ? const SizedBox.shrink()
                      : Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Padding(
                            padding: EdgeInsets.all(getSize(8)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorConstants.white.withOpacity(.8),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(getSize(8)),
                              child: Text(
                                "Coming soon",
                                style: AppStyles.blue000Size12Fw400FfMont,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(
              width: getSize(6),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listTour.nameTour.isNotEmpty ? listTour.nameTour : '',
                      style: AppStyles.botTitle000Size20Fw600FfMont.copyWith(
                          color: appController.isDarkModeOn.value
                              ? ColorConstants.btnCanCel
                              : ColorConstants.botTitle),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                    SizedBox(
                      height: getSize(8.0),
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
                          listTour.rating != 0
                              ? listTour.rating.toString()
                              : "",
                          style: AppStyles.botTitle000Size14Fw400FfMont
                              .copyWith(
                                  color: appController.isDarkModeOn.value
                                      ? ColorConstants.btnCanCel
                                      : ColorConstants.botTitle),
                        ),
                        SizedBox(
                          width: getSize(8.0),
                        ),
                        Text(
                          listTour.reviews != null
                              ? '${listTour.reviews?.toInt()} reviews'
                              : '',
                          style: AppStyles.graySecondSize14Fw400FfMont.copyWith(
                              color: appController.isDarkModeOn.value
                                  ? ColorConstants.btnCanCel
                                  : ColorConstants.graySecond),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getSize(4),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: listTour.price != 0
                                ? '\$${listTour.price}'
                                : "\$143",
                            style: TextStyle(
                              color: appController.isDarkModeOn.value
                                  ? ColorConstants.btnCanCel
                                  : ColorConstants.botTitle,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: "/night",
                            style: AppStyles.botTitle000Size14Fw400FfMont
                                .copyWith(
                                    color: appController.isDarkModeOn.value
                                        ? ColorConstants.btnCanCel
                                        : ColorConstants.botTitle),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => listEmployeeOfTour.value != null &&
                              listEmployeeOfTour.value!.isNotEmpty
                          ? SizedBox(
                              height: getSize(40),
                              width: double.maxFinite,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: listEmployeeOfTour.value!.length,
                                itemBuilder:
                                    (BuildContext context, int rowIndex) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: getSize(8),
                                    ),
                                    child: listEmployeeOfTour.value![rowIndex]
                                                    .imgAvatar !=
                                                "" &&
                                            listEmployeeOfTour.value![rowIndex]
                                                    .imgAvatar !=
                                                null
                                        ? CircleAvatar(
                                            radius: getSize(12),
                                            backgroundImage:
                                                CachedNetworkImageProvider(
                                              listEmployeeOfTour
                                                  .value![rowIndex].imgAvatar!,
                                              maxWidth: getSize(20).toInt(),
                                            ),
                                          )
                                        : CircleAvatar(
                                            radius: getSize(12),
                                            child: SvgPicture.asset(
                                              AssetHelper.icAddUser,
                                              width: getSize(20),
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                  );
                                },
                              ),
                            )
                          : SizedBox(
                              height: getSize(40),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
