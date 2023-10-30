import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

// ignore: must_be_immutable
class LoadingRiveCheck extends StatelessWidget {
  LoadingRiveCheck({
    super.key,
  });

  bool isShowLoading = true;

  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getSize(120),
      width: getSize(120),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(
          getSize(16),
        ),
      ),
      alignment: Alignment.center,
      child: isShowLoading
          ? RiveAnimation.asset(
              "assets/icons/riv/ic_checkerror.riv",
              onInit: (artboard) {
                StateMachineController controller = getRiveController(artboard);
                check = controller.findSMI("Check") as SMITrigger;
                error = controller.findSMI("Error") as SMITrigger;
                reset = controller.findSMI("Reset") as SMITrigger;
              },
            )
          : const SizedBox(),
    );
  }
}
