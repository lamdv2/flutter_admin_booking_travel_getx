import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/modules/tour/chart_item/chart_item_controller.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../shared/constants/assets_helper.dart';

final AppController appController = Get.find();

final List<String> items = [
  "Week".tr,
  "Month".tr,
];

List<Color> gradientColors = [
  Colors.cyan,
  Colors.blue,
];

// ignore: must_be_immutable
class ChartItem extends StatelessWidget {
  String idTour;
  ChartItem({
    super.key,
    required this.idTour,
  });

  final ChartItemController controller = Get.put(ChartItemController());
  @override
  Widget build(BuildContext context) {
    controller.getQuantityTourInWeek(idTour);
    controller.getQuantityTourInMonth(idTour);
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.lightCard,
        borderRadius: BorderRadius.circular(getSize(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: getSize(16),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Analysis",
              style: AppStyles.botTitle000Size20Fw500FfMont,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: getSize(20),
              left: getSize(20),
              right: getSize(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          Expanded(
                            child: Text(
                              controller.selectedValue.value,
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
                                    : AppStyles.titleSearchSize14Fw400FfMont,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                      value: controller.selectedValue.value,
                      onChanged: (value) {
                        controller.selectedValue.value = value!;
                        if (value == "Week") {
                          controller.isCheckWeek.value = true;
                          controller.isCheckMonth.value = false;
                          controller.titleChartLine.value =
                              "Chart of the booking each week";
                        } else if (value == "Month") {
                          controller.isCheckMonth.value = true;
                          controller.isCheckWeek.value = false;
                          controller.titleChartLine.value =
                              "Chart of the booking each month";
                        }
                      },
                      buttonStyleData: ButtonStyleData(
                        height: getSize(50),
                        width: getSize(100),
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
                        width: getSize(160),
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
                Obx(
                  () => Row(
                    children: [
                      GestureDetector(
                        onTap: () => controller.setSpotsMonth10(),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: getSize(6), horizontal: getSize(16)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: controller.isCheckMonth10.value
                                  ? ColorConstants.primaryButton
                                  : ColorConstants.accent1,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "10",
                            style: AppStyles.black000Size12Fw500FfMont.copyWith(
                                color: controller.isCheckMonth10.value
                                    ? ColorConstants.primaryButton
                                    : ColorConstants.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getSize(8),
                      ),
                      GestureDetector(
                        onTap: () => controller.setSpotsMonth100(),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: getSize(6), horizontal: getSize(16)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: controller.isCheckMonth100.value
                                  ? ColorConstants.primaryButton
                                  : ColorConstants.accent1,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "100",
                            style: AppStyles.black000Size12Fw500FfMont.copyWith(
                                color: controller.isCheckMonth100.value
                                    ? ColorConstants.primaryButton
                                    : ColorConstants.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getSize(8),
                      ),
                      GestureDetector(
                        onTap: () => controller.setSpotsMonth1000(),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: getSize(6), horizontal: getSize(16)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: controller.isCheckMonth1000.value
                                  ? ColorConstants.primaryButton
                                  : ColorConstants.accent1,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "1000",
                            style: AppStyles.black000Size12Fw500FfMont.copyWith(
                                color: controller.isCheckMonth1000.value
                                    ? ColorConstants.primaryButton
                                    : ColorConstants.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => AspectRatio(
              aspectRatio: 1.40,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 18,
                  left: 12,
                  top: 24,
                  bottom: 12,
                ),
                child: LineChart(
                  controller.isCheckWeek.value ? avgData() : mainData(),
                ),
              ),
            ),
          ),
          Obx(
            () => Align(
              alignment: Alignment.center,
              child: Text(
                controller.titleChartLine.value,
                style: AppStyles.black000Size12Fw400FfMont,
              ),
            ),
          ),
          SizedBox(
            height: getSize(16),
          ),
        ],
      ),
    );
  }
}

LineChartData avgData() {
  final ChartItemController chartItemController =
      Get.put(ChartItemController());
  return LineChartData(
    lineTouchData: const LineTouchData(enabled: false),
    gridData: FlGridData(
      show: true,
      drawHorizontalLine: true,
      verticalInterval: 1,
      horizontalInterval: 1,
      getDrawingVerticalLine: (value) {
        return const FlLine(
          color: ColorConstants.btnCanCel,
          strokeWidth: 1,
        );
      },
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          color: ColorConstants.btnCanCel,
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: getSize(36),
          getTitlesWidget: bottomTitleWidgetsWeek,
          interval: 1,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: chartItemController.isCheckMonth10.value
              ? leftTitleWidgets10
              : chartItemController.isCheckMonth100.value
                  ? leftTitleWidgets100
                  : leftTitleWidgets1000,
          reservedSize: getSize(40),
          interval: 1,
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: const Color(0xff37434d)),
    ),
    minX: 0,
    maxX: 7,
    minY: 0,
    maxY: 10,
    lineBarsData: [
      LineChartBarData(
        spots: chartItemController.spotsWeek.value ?? [],
        isCurved: true,
        gradient: LinearGradient(
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
          ],
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!
                  .withOpacity(0.1),
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!
                  .withOpacity(0.1),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget leftTitleWidgets10(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  int roundedValue = (value * 10).round();
  String text = '$roundedValue';
  switch (value.toInt()) {
    case 1:
      text = '1';
      break;
    case 2:
      text = '2';
      break;
    case 3:
      text = '3';
      break;
    case 4:
      text = '4';
      break;
    case 5:
      text = '5';
      break;
    case 6:
      text = '6';
      break;
    case 7:
      text = '7';
      break;
    case 8:
      text = '8';
      break;
    case 9:
      text = '9';
      break;
    case 10:
      text = '10';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}

Widget leftTitleWidgets100(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  int roundedValue = (value * 10).round();
  String text = '$roundedValue';
  switch (value.toInt()) {
    case 1:
      text = '10';
      break;
    case 2:
      text = '20';
      break;
    case 3:
      text = '30';
      break;
    case 4:
      text = '40';
      break;
    case 5:
      text = '50';
      break;
    case 6:
      text = '60';
      break;
    case 7:
      text = '70';
      break;
    case 8:
      text = '80';
      break;
    case 9:
      text = '90';
      break;
    case 10:
      text = '100';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}

Widget leftTitleWidgets1000(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  int roundedValue = (value * 10).round();
  String text = '$roundedValue';
  switch (value.toInt()) {
    case 1:
      text = '100';
      break;
    case 2:
      text = '200';
      break;
    case 3:
      text = '300';
      break;
    case 4:
      text = '400';
      break;
    case 5:
      text = '500';
      break;
    case 6:
      text = '600';
      break;
    case 7:
      text = '700';
      break;
    case 8:
      text = '800';
      break;
    case 9:
      text = '900';
      break;
    case 10:
      text = '1000';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}

Widget bottomTitleWidgetsWeek(double value, TitleMeta meta) {
  final style = AppStyles.black000Size12Fw500FfMont;
  late Widget text;

  switch (value.toInt()) {
    case 1:
      text = Text('Mo', style: style);
      break;
    case 2:
      text = Text('Tu', style: style);
      break;
    case 3:
      text = Text('We', style: style);
      break;
    case 4:
      text = Text('Th', style: style);
      break;
    case 5:
      text = Text('Fr', style: style);
      break;
    case 6:
      text = Text('St', style: style);
      break;
    case 7:
      text = Text('Su', style: style);
      break;

    default:
      text = Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  final style = AppStyles.black000Size12Fw500FfMont;
  late Widget text;

  switch (value.toInt()) {
    case 1:
      text = Text('Jan', style: style);
      break;
    case 2:
      text = Text('Feb', style: style);
      break;
    case 3:
      text = Text('Mar', style: style);
      break;
    case 4:
      text = Text('Apr', style: style);
      break;
    case 5:
      text = Text('May', style: style);
      break;
    case 6:
      text = Text('Jun', style: style);
      break;
    case 7:
      text = Text('Jul', style: style);
      break;
    case 8:
      text = Text('Aug', style: style);
      break;
    case 9:
      text = Text('Sep', style: style);
      break;
    case 10:
      text = Text('Oct', style: style);
      break;
    case 11:
      text = Text('Nov', style: style);
      break;
    case 12:
      text = Text('Dec', style: style);
      break;
    default:
      text = Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

LineChartData mainData() {
  final ChartItemController chartItemController =
      Get.put(ChartItemController());
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 1,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          color: Colors.greenAccent,
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return const FlLine(
          color: Colors.greenAccent,
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: getSize(36),
          interval: 1,
          getTitlesWidget: bottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: chartItemController.isCheckMonth10.value
              ? leftTitleWidgets10
              : chartItemController.isCheckMonth100.value
                  ? leftTitleWidgets100
                  : leftTitleWidgets1000,
          reservedSize: getSize(40),
        ),
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: const Color(0xff37434d)),
    ),
    minX: 0,
    maxX: 12,
    minY: 0,
    maxY: 10,
    lineBarsData: [
      LineChartBarData(
        spots: chartItemController.spotsMonth.value ?? [],
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ),
    ],
  );
}
