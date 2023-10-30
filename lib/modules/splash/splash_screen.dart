import 'package:doan_clean_achitec/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            AssetHelper.imgSplashBackground,
          ),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: getSize(250),
          decoration: BoxDecoration(
            color: ColorConstants.blur,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: getSize(16),
            ),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    "Your Journey In",
                    style: TextStyle(
                      fontSize: 32,
                      color: ColorConstants.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "Your Hands",
                    style: TextStyle(
                      fontSize: 32,
                      color: ColorConstants.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: getSize(24),
                  ),
                  child: const Text(
                    "The best travel app in 2023,",
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorConstants.subText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: getSize(8)),
                  child: const Text(
                    "Answer for traveler to find their journey",
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorConstants.subText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: getSize(10),
                ),
                CircleAvatar(
                  backgroundColor: ColorConstants.primaryColor,
                  maxRadius: 24,
                  child: SvgPicture.asset(
                    AssetHelper.icoNextRight,
                    height: getSize(32),
                    width: getSize(32),
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
