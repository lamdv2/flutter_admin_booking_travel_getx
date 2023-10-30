import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/admin/admin_controller.dart';
import 'package:doan_clean_achitec/modules/auth/user_controller.dart';
import 'package:doan_clean_achitec/modules/booking/booking.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BookingRequiedScreen extends StatelessWidget {
  BookingRequiedScreen({super.key});

  final TourModel? tourModel = Get.arguments;
  final UserController userController = Get.put(UserController());
  final AdminController adminController = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    final BookingController bookingController = Get.put(BookingController());

    return Scaffold(
      // appBar: CustomAppBar(),
      backgroundColor: ColorConstants.graySecond,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(
          top: getSize(60),
          bottom: getSize(40),
          right: getSize(40),
          left: getSize(40),
        ),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(
                getSize(28),
              ),
              decoration: BoxDecoration(
                color: ColorConstants.white,
                borderRadius: BorderRadius.circular(
                  getSize(8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: getSize(16),
                  ),
                  Text(
                    tourModel?.nameTour ?? '',
                    style: AppStyles.black000Size18Fw600FfMont,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  SizedBox(height: getSize(16)),
                  Text(
                    tourModel?.duration ?? '',
                    style: AppStyles.black000Size14Fw400FfMont,
                  ),
                  SizedBox(height: getSize(16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Price:',
                        style: AppStyles.black000Size14Fw400FfMont,
                      ),
                      Text(
                        '\$ ${tourModel?.price}',
                        style: AppStyles.black000Size16Fw500FfMont,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(50),
                  ),
                  Text(
                    'Service Excluded',
                    style: AppStyles.black000Size18Fw500FfMont,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  SizedBox(height: getSize(16)),
                  tourModel!.excludedServices!.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: tourModel!.excludedServices!
                              .map(
                                (e) => Padding(
                                  padding: EdgeInsets.only(bottom: getSize(16)),
                                  child: Text(
                                    e,
                                    style: AppStyles.black000Size14Fw400FfMont,
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      : Text(
                          'No data',
                          style: AppStyles.black000Size14Fw400FfMont,
                        ),
                  SizedBox(height: getSize(60)),
                  Text(
                    'Payment Method',
                    style: AppStyles.black000Size18Fw500FfMont,
                  ),
                  SizedBox(height: getSize(16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(
                            getSize(10),
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstants.grayTextField,
                            borderRadius: BorderRadius.circular(
                              getSize(16),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                AssetHelper.icScan,
                                height: getSize(36),
                                width: getSize(36),
                              ),
                              SizedBox(height: getSize(28)),
                              Text(
                                'QR Code',
                                style: AppStyles.black000Size12Fw400FfMont,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getSize(20),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(
                            getSize(10),
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstants.grayTextField,
                            borderRadius: BorderRadius.circular(
                              getSize(16),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                AssetHelper.icBag,
                                height: getSize(36),
                                width: getSize(36),
                              ),
                              SizedBox(height: getSize(28)),
                              Text(
                                'Cash',
                                style: AppStyles.black000Size12Fw400FfMont,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getSize(20),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(
                            getSize(10),
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstants.grayTextField,
                            borderRadius: BorderRadius.circular(
                              getSize(16),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                AssetHelper.icWallet,
                                height: getSize(36),
                                width: getSize(36),
                              ),
                              SizedBox(height: getSize(28)),
                              Text(
                                'Wallet',
                                style: AppStyles.black000Size12Fw400FfMont,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getSize(40),
                    ),
                    child: ButtonWidget(
                      textBtn: 'Yêu cầu đặt',
                      onTap: () async {
                        await bookingController.bookingTour(
                          homeController.userModel.value?.id ?? '',
                          tourModel?.idTour ?? '',
                          adminController
                              .formatDateTime(DateTime.now().toString()),
                          'coming',
                        );
                        Get.offAndToNamed(Routes.HISTORY_TOUR_SCREEN);
                      },
                    ),
                  ),
                  SizedBox(height: getSize(28)),
                ],
              ),
            ),
            Positioned(
              top: getSize(8),
              right: getSize(8),
              child: InkWell(
                onTap: () => Get.back(),
                child: SvgPicture.asset(AssetHelper.icCloseSquare),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
