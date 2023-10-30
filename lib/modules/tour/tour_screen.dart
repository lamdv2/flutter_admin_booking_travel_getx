import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/auth/auth.dart';
import 'package:doan_clean_achitec/modules/booking/booking.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:doan_clean_achitec/modules/tour/tour.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/utils/loading_rive_check.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/search_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../../shared/shared.dart';

class TourScreen extends StatefulWidget {
  const TourScreen({super.key});

  @override
  State<TourScreen> createState() => _TourScreenState();
}

final ProfileController profileController = Get.put(ProfileController());
final AuthController authController = Get.put(AuthController());
final TourController tourController = Get.put(TourController());
final BookingController bookingController = Get.find();
final AppController appController = Get.find();

class _TourScreenState extends State<TourScreen> {
  IconData? iconHeart = FontAwesomeIcons.solidHeart;

  bool isShowLoading = true;
  SMITrigger? check;
  SMITrigger? error;
  SMITrigger? reset;

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  @override
  void initState() {
    super.initState();

    tourController.getAllTourModelData();

    Future.delayed(const Duration(milliseconds: 250), () {
      if (tourController.getListTour.value != null &&
          tourController.getListTour.value!.isNotEmpty) {
        // check?.fire();
        Future.delayed(const Duration(milliseconds: 550), () {
          setState(() {
            isShowLoading = false;
          });
        });
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          // error?.fire();
          setState(() {
            isShowLoading = false;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      StringConst.popular.tr,
      StringConst.newType.tr,
      StringConst.sale.tr,
    ];
    String? selectedValue = StringConst.popular.tr;

    return Scaffold(
      backgroundColor: appController.isDarkModeOn.value
          ? ColorConstants.darkBackground
          : ColorConstants.lightBackground,
      appBar: CustomAppBar(
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkAppBar
            : ColorConstants.primaryButton,
        iconBgrColor: ColorConstants.lightAppBar,
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: tourController.refreshTourList,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: getSize(16),
                horizontal: getSize(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SearchBarWidget(
                      textEditingController: tourController.searchController,
                      onChanged: (value) =>
                          tourController.filterListTourByName(value),
                      hintText: StringConst.searchDestinations.tr),
                  SizedBox(
                    height: getSize(32),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StringConst.preBook.tr,
                      style: AppStyles.botTitle000Size30Fw800FfMont,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: getSize(8),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      StringConst.yourTourPack.tr,
                      style: AppStyles.botTitle000Size28Fw500FfMont,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: getSize(32),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: getSize(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(
                              getSize(20),
                            ),
                            onTap: () {
                              tourController.isCheckSearch.value =
                                  !tourController.isCheckSearch.value;
                              tourController.filterListTourByCity(
                                  bookingController.selectedValue.value);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: getSize(20),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  getSize(22),
                                ),
                                boxShadow: const [],
                                color: tourController.isCheckSearch.value
                                    ? ColorConstants.primaryButton
                                    : appController.isDarkModeOn.value
                                        ? ColorConstants.darkCard
                                        : ColorConstants.lightCard,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                StringConst.city.tr,
                                style: appController.isDarkModeOn.value ||
                                        tourController.isCheckSearch.value
                                    ? AppStyles.white000Size18Fw500FfMont
                                    : AppStyles.black000Size18Fw500FfMont,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getSize(24),
                        ),
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(
                              getSize(20),
                            ),
                            onTap: () {
                              tourController.isCheckSearch.value =
                                  !tourController.isCheckSearch.value;
                              tourController.getAllTour();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: getSize(20),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  getSize(22),
                                ),
                                boxShadow: const [],
                                color: tourController.isCheckSearch.value
                                    ? appController.isDarkModeOn.value
                                        ? ColorConstants.darkCard
                                        : ColorConstants.lightCard
                                    : ColorConstants.primaryButton,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                StringConst.all.tr,
                                style: appController.isDarkModeOn.value ||
                                        !tourController.isCheckSearch.value
                                    ? AppStyles.white000Size18Fw500FfMont
                                    : AppStyles.black000Size18Fw500FfMont,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getSize(28),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        StringConst.filter.tr,
                        style: AppStyles.black000Size18Fw500FfMont.copyWith(
                            color: appController.isDarkModeOn.value
                                ? ColorConstants.lightBackground
                                : ColorConstants.black),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  StringConst.popular.tr,
                                  style: AppStyles.titleSearchSize16Fw400FfMont
                                      .copyWith(
                                    color: appController.isDarkModeOn.value
                                        ? ColorConstants.lightBackground
                                        : ColorConstants.titleSearch,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: items
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: AppStyles
                                          .titleSearchSize14Fw400FfMont
                                          .copyWith(
                                              color: appController
                                                      .isDarkModeOn.value
                                                  ? ColorConstants
                                                      .lightBackground
                                                  : ColorConstants.titleSearch),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            selectedValue = value!;
                            tourController.filterListTourByState(value);
                          },
                          buttonStyleData: ButtonStyleData(
                            height: getSize(50),
                            width: getSize(160),
                            padding: EdgeInsets.symmetric(
                              horizontal: getSize(16),
                              vertical: getSize(8),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorConstants.darkGray.withOpacity(.2),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(
                                getSize(8),
                              ),
                              boxShadow: const [],
                              color: appController.isDarkModeOn.value
                                  ? ColorConstants.darkCard
                                  : ColorConstants.white,
                            ),
                            elevation: 2,
                          ),
                          iconStyleData: IconStyleData(
                            icon: SvgPicture.asset(
                              AssetHelper.icFilter,
                              width: getSize(24),
                              colorFilter: ColorFilter.mode(
                                appController.isDarkModeOn.value
                                    ? ColorConstants.lightBackground!
                                    : ColorConstants.titleSearch,
                                BlendMode.srcIn,
                              ),
                            ),
                            iconEnabledColor: appController.isDarkModeOn.value
                                ? ColorConstants.lightBackground
                                : ColorConstants.botTitle,
                            iconDisabledColor: appController.isDarkModeOn.value
                                ? ColorConstants.lightBackground
                                : Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: getSize(200),
                            width: getSize(200),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: appController.isDarkModeOn.value
                                  ? ColorConstants.darkCard
                                  : ColorConstants.white,
                            ),
                            offset: const Offset(-20, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all(6),
                              thumbVisibility: MaterialStateProperty.all(true),
                            ),
                          ),
                          menuItemStyleData: MenuItemStyleData(
                            height: getSize(40),
                            padding: const EdgeInsets.only(left: 14, right: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getSize(30),
                  ),
                  isShowLoading
                      ? Center(
                          child: SizedBox(
                            height: getSize(120),
                            width: getSize(120),
                            child: RiveAnimation.asset(
                              "assets/icons/riv/ic_checkerror.riv",
                              onInit: (artboard) {
                                StateMachineController controller =
                                    getRiveController(artboard);
                                check =
                                    controller.findSMI("Check") as SMITrigger;
                                error =
                                    controller.findSMI("Error") as SMITrigger;
                                reset =
                                    controller.findSMI("Reset") as SMITrigger;
                              },
                            ),
                          ),
                        )
                      : tourController.getListTour.value != null &&
                              tourController.getListTour.value!.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  tourController.getListTour.value?.length,
                              itemBuilder:
                                  (BuildContext context, int rowIndex) {
                                return Row(
                                  children: [
                                    if (rowIndex > 0)
                                      SizedBox(
                                        height: getSize(24),
                                      ),
                                    Expanded(
                                      child: TourItemWidget(
                                        listTour: tourController
                                            .getListTour.value![rowIndex],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          : LoadingRiveCheck(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
