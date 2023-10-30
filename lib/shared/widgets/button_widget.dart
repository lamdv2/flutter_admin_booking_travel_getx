import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/dimension_constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key, required this.textBtn, this.onTap, this.color, this.gradient})
      : super(key: key);

  final String textBtn;
  final Function()? onTap;
  final Color? color;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kMediumPadding),
          gradient: gradient == null
              ? Gradients.defaultGradientBackground
              : Gradients.defaultGradientButtonCancel,
        ),
        alignment: Alignment.center,
        child: Text(textBtn,
            style: color == null
                ? const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )
                : const TextStyle(
                    color: ColorConstants.primaryColor,
                    fontWeight: FontWeight.bold,
                  )),
      ),
    );
  }
}
