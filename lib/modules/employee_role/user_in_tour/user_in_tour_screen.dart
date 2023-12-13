import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/app_bar_widget.dart';
import 'package:doan_clean_achitec/shared/widgets/stateful/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';

import '../../../models/tour/tour_model.dart';
import '../../../shared/constants/assets_helper.dart';
import '../../../shared/utils/size_utils.dart';
import 'user_in_tour_controller.dart';
import 'user_in_tour_item.dart';

class UserInTourScreen extends StatefulWidget {
  const UserInTourScreen({super.key});

  @override
  State<UserInTourScreen> createState() => _UserInTourScreenState();
}

class _UserInTourScreenState extends State<UserInTourScreen> {
  UserInTourController userInTourController = Get.put(UserInTourController());
  final TourModel? tourModel = Get.arguments;

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
        if (userInTourController.userModel.value != null &&
            userInTourController.userModel.value!.isNotEmpty) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.QR_CODE);
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.qr_code,
          color: Colors.white,
          size: getSize(24),
        ),
      ),
      appBar: CustomAppBar(
        backgroundColor: appController.isDarkModeOn.value
            ? ColorConstants.darkAppBar
            : ColorConstants.primaryButton,
        iconBgrColor: ColorConstants.grayTextField,
        titles: "List User",
      ),
      body: RefreshIndicator(
        onRefresh: userInTourController.refreshTourList,
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
            : ListViewTour(
                userInTourController: userInTourController,
                idTour: tourModel?.idTour ?? "",
              ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ListViewTour extends StatelessWidget {
  ListViewTour({
    super.key,
    required this.userInTourController,
    required this.idTour,
  });

  final UserInTourController userInTourController;
  String idTour;

  @override
  Widget build(BuildContext context) {
    userInTourController.getUserBooking(idTour);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: getSize(28),
                ),
                SearchBarWidget(
                    textEditingController:
                        userInTourController.searchController,
                    onChanged: (value) =>
                        userInTourController.filterListTourByName(value),
                    hintText: "Search user in this tour"),
                SizedBox(
                  height: getSize(32),
                ),
                Obx(
                  () => userInTourController.userModel.value != null &&
                          userInTourController.userModel.value!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              userInTourController.userModel.value?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return UserInTourItemWidget(
                              userModel:
                                  userInTourController.userModel.value![index],
                              isCheckListUserParti: userInTourController
                                  .isCheckListUserParti[index],
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
