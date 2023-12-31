import 'package:doan_clean_achitec/modules/admin/admin_controller.dart';
import 'package:doan_clean_achitec/modules/admin/tour_admin_item_widget.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/search_bar.dart';
import 'package:doan_clean_achitec/shared/widgets/stateless/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:slideable/slideable.dart';

import '../../shared/shared.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  AdminController adminController = Get.put(AdminController());

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

    adminController.getAllTourModelData();

    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (adminController.getListTour.value != null &&
            adminController.getListTour.value!.isNotEmpty) {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkAppBar
            : ColorConstants.primaryButton,
        title: Text(
          StringConst.admins.tr,
          style: AppStyles.white000Size18Fw500FfMont,
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADMIN_CREATE_SCREEN);
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          size: getSize(24),
          color: ColorConstants.lightCard,
        ),
      ),
      drawer: DrawerWidget(),
      body: RefreshIndicator(
        onRefresh: () async {
          adminController.refreshTourList();
          tourController.getAllEmployee();
        },
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
            : ListViewTour(adminController: adminController),
      ),
    );
  }
}

class ListViewTour extends StatelessWidget {
  const ListViewTour({
    super.key,
    required this.adminController,
  });

  final AdminController adminController;

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
                    textEditingController: adminController.searchController,
                    onChanged: (value) =>
                        adminController.filterListTourByName(value),
                    hintText: StringConst.searchDestinations.tr),
                SizedBox(
                  height: getSize(32),
                ),
                Obx(
                  () => adminController.getListTour.value != null &&
                          adminController.getListTour.value!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: adminController.getListTour.value?.length,
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
                                      arguments: adminController
                                          .getListTour.value?[index],
                                    );
                                  },
                                  backgroudColor: Colors.transparent,
                                ),
                                adminController.getListTour.value![index].active
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
                                                      adminController
                                                          .deActiveTour(
                                                        adminController
                                                            .getListTour
                                                            .value![index],
                                                      );
                                                      adminController
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
                                                      adminController
                                                          .activeTour(
                                                        adminController
                                                            .getListTour
                                                            .value![index],
                                                      );
                                                      adminController
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
                              child: TourAdminItemWidget(
                                listTour:
                                    adminController.getListTour.value![index],
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
