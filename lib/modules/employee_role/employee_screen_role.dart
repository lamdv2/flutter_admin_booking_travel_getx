// ignore_for_file: must_be_immutable, camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/models/employee/employee.dart';
import 'package:doan_clean_achitec/modules/employee/employee.dart';
import 'package:doan_clean_achitec/shared/constants/assets_helper.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:slideable/slideable.dart';

import '../../shared/constants/app_style.dart';
import '../../shared/constants/string_constants.dart';
import '../../shared/utils/size_utils.dart';

class EmployeeRoleScreen extends GetView<EmployeeController> {
  EmployeeRoleScreen({super.key});

  final AppController appController = Get.find();
  @override
  EmployeeController controller = Get.put(EmployeeController());

  @override
  Widget build(BuildContext context) {
    controller.getAllEmployee();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          titles: "Info Employee",
          iconBgrColor: ColorConstants.lightStatusBar,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TabBar(
                    isScrollable: true,
                    labelColor: appController.isDarkModeOn.value
                        ? ColorConstants.primaryButton
                        : ColorConstants.primaryButton,
                    unselectedLabelColor: ColorConstants.gray,
                    indicatorColor: appController.isDarkModeOn.value
                        ? ColorConstants.primaryButton
                        : ColorConstants.primaryButton,
                    tabs: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Tab(text: 'Active employee'),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Tab(text: 'Deactive employee'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(getSize(4.0)),
                    child: buildContentTab1(context),
                  ),
                  Padding(
                    padding: EdgeInsets.all(getSize(4.0)),
                    child: buildContentTab2(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildContentTab1(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.getAllEmployee(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(getSize(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Get.to(EmployeeCreateScreen()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Create",
                          style: TextStyle(
                            color: appController.isDarkModeOn.value
                                ? ColorConstants.lightBackground
                                : ColorConstants.graySub,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: getSize(16),
                        ),
                        SvgPicture.asset(
                          AssetHelper.icPlus,
                          width: getSize(28),
                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getSize(16),
                ),
                Obx(
                  () => controller.listAllEmployee.value != null &&
                          controller.listAllEmployee.value!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              controller.listAllEmployee.value?.length ?? 0,
                          itemBuilder: (BuildContext context, int rowIndex) {
                            return Slideable(
                              items: <ActionItems>[
                                ActionItems(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: getSize(28),
                                  ),
                                  onPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            StringConst.confirmation.tr,
                                            style: AppStyles
                                                .black000Size14Fw600FfMont,
                                          ),
                                          content: Text(
                                            "Do you want to deactive employee?"
                                                .tr,
                                            style: AppStyles
                                                .black000Size16Fw400FfMont,
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text(
                                                StringConst.cancel.tr,
                                                style: AppStyles
                                                    .botTitle000Size14Fw400FfMont,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Get.back();
                                                controller.deActiveEmployee(
                                                    controller
                                                            .listAllEmployee
                                                            .value?[rowIndex]
                                                            .id ??
                                                        "");
                                              },
                                              child: Text(
                                                StringConst.ok.tr,
                                                style: AppStyles
                                                    .blue000Size14Fw600FfMont,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  backgroudColor: Colors.transparent,
                                )
                              ],
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: getSize(12)),
                                child: _buildItemEmployee(
                                  employeeModel: controller
                                      .listAllEmployee.value?[rowIndex],
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Container(
                            width: double.infinity,
                            padding:
                                EdgeInsets.symmetric(horizontal: getSize(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  AssetHelper.imgLottieNodate,
                                  width: getSize(200),
                                  height: getSize(200),
                                  fit: BoxFit.fill,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getSize(48.0),
                                  ),
                                  child: Text(
                                    'There are currently no employees',
                                    style: AppStyles.black000Size14Fw400FfMont
                                        .copyWith(
                                      color: appController.isDarkModeOn.value
                                          ? ColorConstants.lightAppBar
                                          : ColorConstants.darkBackground,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildContentTab2(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.getAllEmployeeDeactive(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(getSize(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getSize(16),
                ),
                Obx(
                  () => controller.listAllEmployeeDeactive.value != null &&
                          controller.listAllEmployeeDeactive.value!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller
                                  .listAllEmployeeDeactive.value?.length ??
                              0,
                          itemBuilder: (BuildContext context, int rowIndex) {
                            return Slideable(
                              items: <ActionItems>[
                                ActionItems(
                                  icon: Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: getSize(28),
                                  ),
                                  onPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            StringConst.confirmation.tr,
                                            style: AppStyles
                                                .black000Size14Fw600FfMont,
                                          ),
                                          content: Text(
                                            "Do you want to reactivate your employee?"
                                                .tr,
                                            style: AppStyles
                                                .black000Size16Fw400FfMont,
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text(
                                                StringConst.cancel.tr,
                                                style: AppStyles
                                                    .botTitle000Size14Fw400FfMont,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Get.back();
                                                controller.reActiveEmployee(
                                                  controller
                                                          .listAllEmployeeDeactive
                                                          .value?[rowIndex]
                                                          .id ??
                                                      "",
                                                );
                                              },
                                              child: Text(
                                                StringConst.ok.tr,
                                                style: AppStyles
                                                    .blue000Size14Fw600FfMont,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  backgroudColor: Colors.transparent,
                                ),
                              ],
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(vertical: getSize(12)),
                                child: _buildItemEmployee(
                                  employeeModel: controller
                                      .listAllEmployeeDeactive.value?[rowIndex],
                                ),
                              ),
                            );
                          },
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: double.infinity,
                            padding:
                                EdgeInsets.symmetric(horizontal: getSize(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: getSize(32),
                                ),
                                Lottie.asset(
                                  AssetHelper.imgLottieNodate,
                                  width: getSize(200),
                                  height: getSize(200),
                                  fit: BoxFit.fill,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getSize(48.0),
                                  ),
                                  child: Text(
                                    'There are currently no employees',
                                    style: AppStyles.black000Size14Fw400FfMont
                                        .copyWith(
                                      color: appController.isDarkModeOn.value
                                          ? ColorConstants.lightAppBar
                                          : ColorConstants.darkBackground,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _buildItemEmployee extends StatelessWidget {
  EmployeeModel? employeeModel;

  _buildItemEmployee({
    required this.employeeModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(12),
        vertical: getSize(10),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorConstants.lightCard,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${employeeModel?.firstName ?? ''} ${employeeModel?.lastName ?? ''}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyles.black000Size16Fw500FfMont,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  employeeModel?.phoneNub ?? '',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyles.black000Size16Fw500FfMont,
                ),
                SizedBox(
                  height: getSize(8),
                ),
                Text(
                  '${employeeModel?.email}',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyles.blue000Size14Fw400FfMont,
                ),
              ],
            ),
          ),
          SizedBox(
            width: getSize(30),
          ),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(getSize(16)),
              child: employeeModel?.imgAvatar != null &&
                      employeeModel?.imgAvatar != ""
                  ? CachedNetworkImage(
                      height: getSize(96),
                      width: getSize(96),
                      fit: BoxFit.cover,
                      imageUrl: employeeModel?.imgAvatar ?? '',
                    )
                  : Image.asset(
                      AssetHelper.icoUser,
                      height: getSize(60),
                      width: getSize(60),
                      fit: BoxFit.fitHeight,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
