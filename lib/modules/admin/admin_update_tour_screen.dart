import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/models/tour/type_service_search.dart';
import 'package:doan_clean_achitec/modules/admin/admin_controller.dart';
import 'package:doan_clean_achitec/modules/home/home_screen.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/utils/convert_date_time.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:doan_clean_achitec/shared/widgets/my_textfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AdminUpdateScreen extends StatefulWidget {
  const AdminUpdateScreen({super.key});

  @override
  State<AdminUpdateScreen> createState() => _AdminUpdateScreenState();
}

class _AdminUpdateScreenState extends State<AdminUpdateScreen> {
  AdminController adminController = Get.put(AdminController());
  final _formUpdateKey = GlobalKey<FormState>();

  final List<String> items = [
    StringConst.popular.tr,
    StringConst.newType.tr,
    StringConst.sale.tr,
  ];

  String startDateSelected = '';
  String endDateSelected = '';

  List<Widget> _children = [];
  int _count = 0;
  List<TextEditingController> _controllers = [];
  List<String> listIti = [];

  final TourModel? tourModel = Get.arguments;

  final List<TypeServiceSearch> itemsTypeTour = [
    TypeServiceSearch(
      isCheck: false,
      typeNub: 0,
      valueType: 'Places to visit and sightsee',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 1,
      valueType: 'Historical sites',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 2,
      valueType: 'Sports events',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 3,
      valueType: 'Sports event',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 4,
      valueType: 'Entertainment',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 5,
      valueType: 'Adventure activities & extreme sports',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 6,
      valueType: 'Farm tourism',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 7,
      valueType: 'Underwater activities',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 8,
      valueType: 'Cultural experience',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 9,
      valueType: 'Half day tour/Day tour',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 10,
      valueType: 'Multi-day tour',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 11,
      valueType: 'Retaurant',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 12,
      valueType: 'Desserts & drinks',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 13,
      valueType: 'Hotel',
    ),
    TypeServiceSearch(
      isCheck: false,
      typeNub: 14,
      valueType: 'Travel equipment & related services',
    ),
  ];

  @override
  void initState() {
    super.initState();
    adminController.nameTourController.text = tourModel?.nameTour ?? '';
    adminController.descriptionController.text = tourModel?.description ?? '';
    adminController.idCityController.text = tourModel?.idCity ?? '';
    adminController.startDateController.text =
        tourModel?.startDate.toString() ?? '';
    adminController.endDateController.text =
        tourModel?.endDate.toString() ?? '';
    adminController.priceController.text = tourModel?.price.toString() ?? '';
    adminController.durationController.text = tourModel?.duration ?? '';
    adminController.accommodationController.text =
        tourModel?.accommodation ?? '';
    listIti = tourModel?.itinerary ?? [];
    adminController.ratingController.text = tourModel?.rating.toString() ?? '';
    adminController.activeController.text = tourModel?.accommodation ?? '';
    adminController.statusController.text = tourModel?.status ?? "";
    adminController.typeTourController.text = tourModel?.type.toString() ?? "";
    startDateSelected =
        adminController.timestampToString(tourModel!.startDate!);
    endDateSelected = adminController.timestampToString(tourModel!.endDate!);
    _gen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titles: StringConst.updateTour.tr,
        iconBgrColor: ColorConstants.grayTextField,
        onTap: () {
          Get.back();
          adminController.clearController();
        },
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formUpdateKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getSize(36),
                    ),
                    Text(
                      StringConst.nameTour.tr,
                      style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.bgrLight
                            : ColorConstants.graySub,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getSize(12),
                    ),
                    MyTextField(
                      controller: adminController.nameTourController,
                      hintText: StringConst.enterNameTour.tr,
                      obscureText: false,
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Text(
                      StringConst.descriptionTour.tr,
                      style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.bgrLight
                            : ColorConstants.graySub,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getSize(12),
                    ),
                    MyTextField(
                      controller: adminController.descriptionController,
                      hintText: StringConst.enterDescriptionTour.tr,
                      obscureText: false,
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Text(
                      "Type Tour".tr,
                      style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.bgrLight
                            : ColorConstants.graySub,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getSize(12),
                    ),
                    Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  adminController.selectedValueTypeTour.value,
                                  style: AppStyles.titleSearchSize16Fw400FfMont,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: adminController.listTypeSearchService.value !=
                                      null &&
                                  adminController
                                      .listTypeSearchService.value!.isNotEmpty
                              ? adminController.listTypeSearchService.value!
                                  .map(
                                    (TypeServiceSearch item) =>
                                        DropdownMenuItem<String>(
                                      value: item.valueType,
                                      child: Text(
                                        item.valueType,
                                        style: appController.isDarkModeOn.value
                                            ? AppStyles.graySize14Fw400FfMont
                                            : AppStyles
                                                .titleSearchSize14Fw400FfMont,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                  .toList()
                              : itemsTypeTour
                                  .map(
                                    (TypeServiceSearch item) =>
                                        DropdownMenuItem<String>(
                                      value: item.valueType,
                                      child: Text(
                                        item.valueType,
                                        style: appController.isDarkModeOn.value
                                            ? AppStyles.graySize14Fw400FfMont
                                            : AppStyles
                                                .titleSearchSize14Fw400FfMont,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                  .toList(),
                          value: adminController.selectedValueTypeTour.value,
                          onChanged: (value) {
                            adminController.selectedValueTypeTour.value =
                                value!;
                            adminController.typeTourController.text =
                                adminController
                                    .typeTourIndex(adminController
                                        .selectedValueTypeTour.value)
                                    .toString();
                          },
                          buttonStyleData: ButtonStyleData(
                            height: getSize(50),
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: getSize(16),
                              vertical: getSize(8),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: appController.isDarkModeOn.value
                                    ? ColorConstants.accent1
                                    : ColorConstants.darkGray.withOpacity(.5),
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
                                    ? ColorConstants.white
                                    : ColorConstants.accent1,
                                BlendMode.srcIn,
                              ),
                            ),
                            iconEnabledColor: appController.isDarkModeOn.value
                                ? ColorConstants.lightCard
                                : ColorConstants.botTitle,
                            iconDisabledColor: Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: getSize(360),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: appController.isDarkModeOn.value
                                  ? ColorConstants.darkCard
                                  : Colors.grey.shade100,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: getSize(20),
                            ),
                            offset: const Offset(-20, -4),
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
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Text(
                      "Start At".tr,
                      style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.bgrLight
                            : ColorConstants.graySub,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getSize(12),
                    ),
                    MyTextField(
                      controller: adminController.accommodationController,
                      hintText: "Enter location start",
                      obscureText: false,
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Text(
                      StringConst.idCityTour.tr,
                      style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.bgrLight
                            : ColorConstants.graySub,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getSize(12),
                    ),
                    Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  adminController.selectedValue.value,
                                  style: AppStyles.titleSearchSize16Fw400FfMont,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: tourController.items.value != null
                              ? tourController.items.value!
                                  .map(
                                    (String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: appController.isDarkModeOn.value
                                            ? AppStyles.graySize14Fw400FfMont
                                            : AppStyles
                                                .titleSearchSize14Fw400FfMont,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                  .toList()
                              : items
                                  .map(
                                    (String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: appController.isDarkModeOn.value
                                            ? AppStyles.graySize14Fw400FfMont
                                            : AppStyles
                                                .titleSearchSize14Fw400FfMont,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                  .toList(),
                          value: adminController.selectedValue.value,
                          onChanged: (value) {
                            adminController.selectedValue.value = value!;
                            adminController.idCityController.text =
                                adminController.selectedValue.value;
                          },
                          buttonStyleData: ButtonStyleData(
                            height: getSize(50),
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: getSize(16),
                              vertical: getSize(8),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: appController.isDarkModeOn.value
                                    ? ColorConstants.accent1
                                    : ColorConstants.darkGray.withOpacity(.5),
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
                                    ? ColorConstants.white
                                    : ColorConstants.accent1,
                                BlendMode.srcIn,
                              ),
                            ),
                            iconEnabledColor: appController.isDarkModeOn.value
                                ? ColorConstants.lightCard
                                : ColorConstants.botTitle,
                            iconDisabledColor: Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: getSize(200),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: appController.isDarkModeOn.value
                                  ? ColorConstants.darkCard
                                  : Colors.grey.shade100,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: getSize(20),
                            ),
                            offset: const Offset(-20, -4),
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
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Text(
                      "Sale Tour".tr,
                      style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.bgrLight
                            : ColorConstants.graySub,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getSize(12),
                    ),
                    Obx(
                      () => DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  adminController.selectedValueSaleTour.value,
                                  style: AppStyles.titleSearchSize16Fw400FfMont,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: items
                              .map(
                                (String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: appController.isDarkModeOn.value
                                        ? AppStyles.graySize14Fw400FfMont
                                        : AppStyles
                                            .titleSearchSize14Fw400FfMont,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                              .toList(),
                          value: adminController.selectedValueSaleTour.value,
                          onChanged: (value) {
                            adminController.selectedValueSaleTour.value =
                                value!;
                            adminController.statusController.text =
                                adminController.selectedValueSaleTour.value;
                          },
                          buttonStyleData: ButtonStyleData(
                            height: getSize(50),
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: getSize(16),
                              vertical: getSize(8),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: appController.isDarkModeOn.value
                                    ? ColorConstants.accent1
                                    : ColorConstants.darkGray.withOpacity(.5),
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
                                    ? ColorConstants.white
                                    : ColorConstants.accent1,
                                BlendMode.srcIn,
                              ),
                            ),
                            iconEnabledColor: appController.isDarkModeOn.value
                                ? ColorConstants.lightCard
                                : ColorConstants.botTitle,
                            iconDisabledColor: Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: getSize(200),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: appController.isDarkModeOn.value
                                  ? ColorConstants.darkCard
                                  : Colors.grey.shade100,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: getSize(20),
                            ),
                            offset: const Offset(-20, -4),
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
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Text(
                      StringConst.startDateTour.tr,
                      style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.bgrLight
                            : ColorConstants.graySub,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getSize(12),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            appController.isDarkModeOn.value
                                ? ColorConstants.darkCard
                                : ColorConstants.white,
                          ),
                        ),
                        onPressed: () async {
                          final result = await Get.toNamed(Routes.SELECT_DATE);
                          if (result is List<DateTime?>) {
                            startDateSelected = '${result[0]?.getDate}';
                            setState(() {
                              adminController.startDateController.text =
                                  startDateSelected;
                            });
                          }
                        },
                        child: Text(
                          startDateSelected,
                          style: appController.isDarkModeOn.value
                              ? AppStyles.white000Size14Fw400FfMont
                              : AppStyles.black000Size14Fw400FfMont,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Text(
                      StringConst.endDateTour.tr,
                      style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.bgrLight
                            : ColorConstants.graySub,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getSize(12),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            appController.isDarkModeOn.value
                                ? ColorConstants.darkCard
                                : ColorConstants.white,
                          ),
                        ),
                        onPressed: () async {
                          final result = await Get.toNamed(Routes.SELECT_DATE);
                          if (result is List<DateTime?>) {
                            endDateSelected = '${result[1]?.getDate}';
                            setState(() {
                              adminController.endDateController.text =
                                  endDateSelected;
                            });
                          }
                        },
                        child: Text(
                          endDateSelected,
                          style: appController.isDarkModeOn.value
                              ? AppStyles.white000Size14Fw400FfMont
                              : AppStyles.black000Size14Fw400FfMont,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Text(
                      StringConst.priceTour.tr,
                      style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.bgrLight
                            : ColorConstants.graySub,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getSize(12),
                    ),
                    MyTextField(
                      controller: adminController.priceController,
                      hintText: StringConst.enterPriceTour.tr,
                      obscureText: false,
                      isTypeNumb: true,
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Row(
                      children: [
                        Text(
                          StringConst.itineraryTour.tr,
                          style: TextStyle(
                            color: appController.isDarkModeOn.value
                                ? ColorConstants.bgrLight
                                : ColorConstants.graySub,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: IconButton(
                            onPressed: _add,
                            icon: Icon(
                              Icons.add,
                              size: getSize(16),
                              color: appController.isDarkModeOn.value
                                  ? ColorConstants.bgrLight
                                  : ColorConstants.accent1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    MyTextField(
                      controller: adminController.itineraryController,
                      hintText: StringConst.enterItineraryTour.tr,
                      obscureText: false,
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _children.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: getSize(16)),
                          child: _children[index],
                        );
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          StringConst.imageTour.tr,
                          style: TextStyle(
                            color: appController.isDarkModeOn.value
                                ? ColorConstants.bgrLight
                                : ColorConstants.graySub,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: IconButton(
                            onPressed: () =>
                                adminController.pickImages(context),
                            icon: Icon(
                              Icons.add,
                              size: getSize(16),
                              color: appController.isDarkModeOn.value
                                  ? ColorConstants.bgrLight
                                  : ColorConstants.accent1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Obx(
                      () => adminController.imageTours.value.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  adminController.imageTours.value.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(bottom: getSize(16)),
                                  child: SizedBox(
                                    width: 64,
                                    height: 200,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: AssetEntityImage(
                                        adminController.imageTours.value[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : const SizedBox.shrink(),
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Text(
                      StringConst.ratingTour.tr,
                      style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.bgrLight
                            : ColorConstants.graySub,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getSize(12),
                    ),
                    MyTextField(
                      controller: adminController.ratingController,
                      hintText: StringConst.enterRatingTour.tr,
                      obscureText: false,
                      isTypeNumb: true,
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () async {
                          adminController.listImageToursChecked.value =
                              await adminController.assetEntitiesToUint8Lists(
                            adminController.imageTours.value,
                          );
                          adminController.listImageTours.value =
                              await adminController.uploadImagesToStorage(
                            adminController.nameTourController.text,
                            adminController.listImageToursChecked.value ?? [],
                          );
                          if (_formUpdateKey.currentState!.validate()) {
                            final TourModel tourModelUpdate = TourModel(
                              idTour: tourModel?.idTour ?? "",
                              nameTour: adminController.nameTourController.text,
                              description:
                                  adminController.descriptionController.text,
                              idCity: adminController.idCityController.text,
                              startDate: adminController.formatDateTime(
                                  adminController.startDateController.text),
                              endDate: adminController.formatDateTime(
                                  adminController.endDateController.text),
                              price: double.parse(
                                  adminController.priceController.text),
                              images: adminController.listImageTours.value,
                              duration: adminController.calculateDaysDifference(
                                adminController.formatDateTime(
                                    adminController.startDateController.text),
                                adminController.formatDateTime(
                                    adminController.endDateController.text),
                              ),
                              accommodation:
                                  adminController.accommodationController.text,
                              itinerary: listIti,
                              includedServices: listIti,
                              excludedServices: List.empty(),
                              reviews: 0,
                              rating: double.parse(
                                  adminController.ratingController.text),
                              active: true,
                              type: double.parse(
                                  adminController.typeTourController.text),
                              specialOffers: List.empty(),
                              status: adminController.statusController.text,
                            );
                            _save(_controllers);
                            adminController
                                .editTourDetailsById(tourModelUpdate);
                            adminController.clearController();
                          } else {
                            Get.snackbar("Error", "validate");
                          }

                          Get.back();
                          adminController.getAllTourModelData();
                        },
                        child: Text(StringConst.updateTour.tr),
                      ),
                    ),
                    SizedBox(
                      height: getSize(24),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _add() {
    TextEditingController newController = TextEditingController();
    _controllers.add(newController);

    _children = List.from(_children)
      ..add(
        MyTextField(
          controller: newController,
          hintText: StringConst.enterItineraryOfTour.tr,
          obscureText: false,
        ),
      );

    setState(() => ++_count);
  }

  void _gen() {
    for (var e in listIti) {
      TextEditingController newController = TextEditingController();
      newController.text = e;
      _controllers.add(newController);

      _children = List.from(_children)
        ..add(
          MyTextField(
            controller: newController,
            hintText: StringConst.itineraryOfTour.tr,
            obscureText: false,
          ),
        );

      setState(() => ++_count);
    }
  }

  void _save(List<TextEditingController> controllers) {
    listIti.clear();
    for (TextEditingController controller in controllers) {
      listIti.add(controller.text);
    }
  }
}
