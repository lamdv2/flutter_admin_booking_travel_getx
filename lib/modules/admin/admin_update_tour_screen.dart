import 'package:doan_clean_achitec/models/tour/tour_model.dart';
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

class AdminUpdateScreen extends StatefulWidget {
  const AdminUpdateScreen({super.key});

  @override
  State<AdminUpdateScreen> createState() => _AdminUpdateScreenState();
}

class _AdminUpdateScreenState extends State<AdminUpdateScreen> {
  AdminController adminController = Get.put(AdminController());
  final _formUpdateKey = GlobalKey<FormState>();

  final List<String> items = [
    '50HCM',
    '43DN',
    '29HN',
  ];

  final List<Map<String, String>> itemsName = [
    {'50HCM': 'Hồ Chí Minh'},
    {'43DN': 'Đà Nẵng'},
    {'29HN': 'Hà Nội'},
  ];

  String startDateSelected = '';
  String endDateSelected = '';

  List<Widget> _children = [];
  int _count = 0;
  List<TextEditingController> _controllers = [];
  List<String> listIti = [];

  final TourModel? tourModel = Get.arguments;

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
                            ? ColorConstants.lightGray
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
                            ? ColorConstants.lightGray
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
                      StringConst.idCityTour.tr,
                      style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.lightGray
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
                                        style: AppStyles
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
                                        style: AppStyles
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
                                color: ColorConstants.darkGray.withOpacity(.5),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(
                                getSize(8),
                              ),
                              boxShadow: const [],
                              color: ColorConstants.white,
                            ),
                            elevation: 2,
                          ),
                          iconStyleData: IconStyleData(
                            icon: SvgPicture.asset(
                              AssetHelper.icFilter,
                              width: getSize(24),
                            ),
                            iconEnabledColor: ColorConstants.botTitle,
                            iconDisabledColor: Colors.grey,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: getSize(200),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.grey.shade100,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: getSize(20),
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
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Text(
                      StringConst.startDateTour.tr,
                      style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.lightGray
                            : ColorConstants.graySub,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getSize(12),
                    ),
                    Container(
                      width: double.infinity,
                      color: ColorConstants.white,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorConstants.white),
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
                          style: AppStyles.black000Size14Fw400FfMont,
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
                            ? ColorConstants.lightGray
                            : ColorConstants.graySub,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: getSize(12),
                    ),
                    Container(
                      width: double.infinity,
                      color: ColorConstants.white,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorConstants.white),
                        ),
                        onPressed: () async {
                          final result = await Get.toNamed(Routes.SELECT_DATE);
                          if (result is List<DateTime?>) {
                            endDateSelected = '${result[0]?.getDate}';
                            setState(() {
                              adminController.endDateController.text =
                                  endDateSelected;
                            });
                          }
                        },
                        child: Text(
                          endDateSelected,
                          style: AppStyles.black000Size14Fw400FfMont,
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
                            ? ColorConstants.lightGray
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
                                ? ColorConstants.lightGray
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
                              color: ColorConstants.accent1,
                            ),
                          ),
                        ),
                      ],
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
                    SizedBox(
                      height: getSize(16),
                    ),
                    Text(
                      StringConst.ratingTour.tr,
                      style: TextStyle(
                        color: appController.isDarkModeOn.value
                            ? ColorConstants.lightGray
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
                    ),
                    SizedBox(
                      height: getSize(16),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () {
                          final TourModel tourModelUpdate = TourModel(
                            idTour: tourModel?.idTour ?? '',
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
                            images: List.empty(),
                            duration: adminController.durationController.text,
                            accommodation:
                                adminController.accommodationController.text,
                            itinerary: listIti,
                            includedServices: List.empty(),
                            excludedServices: List.empty(),
                            reviews: List.empty(),
                            rating: double.parse(
                                adminController.ratingController.text),
                            active: true,
                            specialOffers: List.empty(),
                            status: adminController.statusController.text,
                          );
                          _save(_controllers);
                          adminController.editTourDetailsById(tourModelUpdate);
                          adminController.clearController();
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
