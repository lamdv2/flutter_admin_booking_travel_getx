import 'package:doan_clean_achitec/modules/employee_role/home_tab/home_employee_controller.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:slideable/slideable.dart';

import '../../../shared/constants/assets_helper.dart';
import '../../../shared/constants/string_constants.dart';
import '../../../shared/utils/size_utils.dart';
import 'tour_home_employee_item_widget.dart';

class HomeEmployeeScreen extends StatefulWidget {
  const HomeEmployeeScreen({super.key});

  @override
  State<HomeEmployeeScreen> createState() => _HomeEmployeeScreenState();
}

class _HomeEmployeeScreenState extends State<HomeEmployeeScreen> {
  HomeEmployeeController homeEmployeeController =
      Get.put(HomeEmployeeController());

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

    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (homeEmployeeController.getListTour.value != null &&
            homeEmployeeController.getListTour.value!.isNotEmpty) {
          // check?.fire();
          Future.delayed(const Duration(seconds: 1), () {
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => homeEmployeeController.onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appController.isDarkModeOn.value
              ? ColorConstants.darkAppBar
              : ColorConstants.primaryButton,
          title: const Text("Employee"),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: homeEmployeeController.refreshTourList,
          child: isShowLoading
              ? Center(
                  child: SizedBox(
                    height: getSize(120),
                    width: getSize(120),
                    child: RiveAnimation.asset(
                      "assets/icons/riv/ic_checkerror.riv",
                      onInit: (artboard) {
                        StateMachineController controller =
                            getRiveController(artboard);
                        check = controller.findSMI("Check") as SMITrigger;
                        error = controller.findSMI("Error") as SMITrigger;
                        reset = controller.findSMI("Reset") as SMITrigger;
                      },
                    ),
                  ),
                )
              : ListViewTour(homeEmployeeController: homeEmployeeController),
        ),
      ),
    );
  }
}

class ListViewTour extends StatelessWidget {
  const ListViewTour({
    super.key,
    required this.homeEmployeeController,
  });

  final HomeEmployeeController homeEmployeeController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: getSize(36),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    StringConst.allTour.tr,
                    style: appController.isDarkModeOn.value
                        ? AppStyles.white000Size18Fw500FfMont
                        : AppStyles.black000Size18Fw500FfMont,
                  ),
                ),
                SizedBox(
                  height: getSize(16),
                ),
                SearchBarWidget(
                    textEditingController:
                        homeEmployeeController.searchController,
                    onChanged: (value) =>
                        homeEmployeeController.filterListTourByName(value),
                    hintText: StringConst.searchDestinations.tr),
                SizedBox(
                  height: getSize(32),
                ),
                Obx(
                  () => homeEmployeeController.getListTour.value != null &&
                          homeEmployeeController.getListTour.value!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              homeEmployeeController.getListTour.value?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Slideable(
                              items: <ActionItems>[
                                ActionItems(
                                  icon: Icon(
                                    Icons.update_outlined,
                                    color: Colors.blue,
                                    size: getSize(28),
                                  ),
                                  onPress: () {
                                    Get.toNamed(
                                      Routes.ADMIN_UPDATE_SCREEN,
                                      arguments: homeEmployeeController
                                          .getListTour.value?[index],
                                    );
                                  },
                                  backgroudColor: Colors.transparent,
                                ),
                                homeEmployeeController
                                        .getListTour.value![index].active
                                    ? ActionItems(
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
                                                  StringConst
                                                      .doYouWantDelete.tr,
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
                                                      homeEmployeeController
                                                          .deActiveTour(
                                                        homeEmployeeController
                                                            .getListTour
                                                            .value![index],
                                                      );
                                                      homeEmployeeController
                                                          .getAllTourModelData();
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
                                    : ActionItems(
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
                                                  "Do you want the tour to operate again?"
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
                                                      homeEmployeeController
                                                          .activeTour(
                                                        homeEmployeeController
                                                            .getListTour
                                                            .value![index],
                                                      );
                                                      homeEmployeeController
                                                          .getAllTourModelData();
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
                              child: TourHomeEmployeeItemWidget(
                                listTour: homeEmployeeController
                                    .getListTour.value![index],
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Lottie.asset(
                            AssetHelper.imgLottieNodate,
                            width: getSize(200),
                            height: getSize(200),
                            fit: BoxFit.fill,
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
