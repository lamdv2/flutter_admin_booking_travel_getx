import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/constants/dimension_constants.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:doan_clean_achitec/shared/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// ignore: must_be_immutable
class SelectDateScreen extends StatelessWidget {
  SelectDateScreen({Key? key}) : super(key: key);

  final AppController appController = Get.find();

  DateTime? rangeStartDate;
  DateTime? rangeEndDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(getSize(30)),
        child: Column(
          children: [
            SizedBox(
              height: getSize(40),
            ),
            Text(
              'Select Date',
              style: AppStyles.black000Size18Fw500FfMont.copyWith(
                  color: appController.isDarkModeOn.value
                      ? ColorConstants.white
                      : ColorConstants.black),
            ),
            SizedBox(
              height: getSize(60),
            ),
            SfDateRangePicker(
              view: DateRangePickerView.month,
              selectionMode: DateRangePickerSelectionMode.range,
              monthViewSettings:
                  const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
              selectionColor: ColorConstants.yellow,
              startRangeSelectionColor: ColorConstants.yellow,
              endRangeSelectionColor: ColorConstants.yellow,
              rangeSelectionColor: ColorConstants.yellow.withOpacity(0.25),
              todayHighlightColor: ColorConstants.yellow,
              toggleDaySelection: true,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is PickerDateRange) {
                  rangeStartDate = args.value.startDate;
                  rangeEndDate = args.value.endDate;
                } else {
                  rangeStartDate = null;
                  rangeEndDate = null;
                }
              },
            ),
            SizedBox(
              height: getSize(32),
            ),
            ButtonWidget(
              textBtn: 'Select',
              onTap: () {
                Get.back(result: [rangeStartDate, rangeEndDate]);
              },
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            ButtonWidget(
              textBtn: 'Cancel',
              color: Colors.white70,
              onTap: () {
                Get.back();
              },
              gradient: Gradients.defaultGradientButtonCancel,
            ),
          ],
        ),
      ),
    );
  }
}
