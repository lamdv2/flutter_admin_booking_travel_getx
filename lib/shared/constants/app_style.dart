import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dark_mode.dart';
import 'colors.dart';

class FontFamily {
  static const mont = 'Montserrat';
  static const inter = 'Inter';
}

class AppStyles {
  static AppController appController = Get.find();

  // white
  static TextStyle white000Size30Fw600FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 30.00,
    fontWeight: FontWeight.w600,
    color: ColorConstants.white,
  );

  static TextStyle white000Size24Fw600FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 24.00,
    fontWeight: FontWeight.w600,
    color: ColorConstants.white,
  );

  static TextStyle white000Size24Fw400FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 24.00,
    fontWeight: FontWeight.w400,
    color: ColorConstants.white,
  );

  static TextStyle white000Size18FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 18.72,
    color: ColorConstants.white,
  );

  static TextStyle white000Size20Fw500FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 20.00,
    fontWeight: FontWeight.w500,
    color: ColorConstants.white,
  );

  static TextStyle white000Size18Fw500FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 18.72,
    fontWeight: FontWeight.w500,
    color: appController.isDarkModeOn.value
        ? ColorConstants.darkCard
        : ColorConstants.white,
  );

  static TextStyle white000Size16FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 16.00,
    color: ColorConstants.white,
  );

  static TextStyle white000Size13FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 13.28,
    color: ColorConstants.white,
  );

  static TextStyle white000Size14Fw400FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorConstants.white,
  );

  static TextStyle white000Size14Fw500FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ColorConstants.white,
  );

  static TextStyle white000Size12Fw400FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorConstants.white,
  );

  static TextStyle white000Size10FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 10.72,
    color: ColorConstants.white,
  );

  // black
  static TextStyle black000Size30Fw600FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 28.00,
    fontWeight: FontWeight.w600,
    color: ColorConstants.black,
  );

  static TextStyle black000Size24Fw600FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 24.00,
    fontWeight: FontWeight.w600,
    color: ColorConstants.black,
  );

  static TextStyle black000Size24Fw500FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 24.00,
    fontWeight: FontWeight.w500,
    color: ColorConstants.black,
  );

  static TextStyle black000Size24Fw400FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 24.00,
    fontWeight: FontWeight.w400,
    color: ColorConstants.black,
  );

  static TextStyle black000Size18FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 18.72,
    color: ColorConstants.black,
  );

  static TextStyle black000Size18Fw600FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 18.72,
    fontWeight: FontWeight.w600,
    color: ColorConstants.black,
  );

  static TextStyle black000Size16Fw500FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 16.00,
    fontWeight: FontWeight.w500,
    color: ColorConstants.black,
  );

  static TextStyle black000Size16Fw400FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 16.00,
    fontWeight: FontWeight.w400,
    color: ColorConstants.black,
  );

  static TextStyle black000Size16Fw700FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 16.00,
    fontWeight: FontWeight.w700,
    color: ColorConstants.black,
  );

  static TextStyle black000Size18Fw500FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 18.00,
    fontWeight: FontWeight.w500,
    color: ColorConstants.black,
  );

  static TextStyle black000Size12Fw500FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: ColorConstants.black,
  );

  static TextStyle black000Size12Fw400FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorConstants.black,
  );

  static TextStyle black000Size10FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 10.72,
    color: ColorConstants.black,
  );

  static TextStyle black000Size10Fw500FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: ColorConstants.black,
  );

  static TextStyle black000Size20Fw500FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: appController.isDarkModeOn.value
        ? ColorConstants.white
        : ColorConstants.black,
  );

  static TextStyle black000Size14Fw400FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: appController.isDarkModeOn.value
        ? ColorConstants.lightCard
        : ColorConstants.black,
  );

  static TextStyle black000Size14Fw600FfMont = TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ColorConstants.black,
  );

  // botTitle
  static TextStyle botTitle000Size12Fw400FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorConstants.botTitle,
  );

  static TextStyle botTitle000Size14Fw400FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorConstants.botTitle,
  );

  static TextStyle botTitle000Size20Fw500FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: ColorConstants.botTitle,
  );

  static TextStyle botTitle000Size28Fw500FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 28,
    fontWeight: FontWeight.w500,
    color: ColorConstants.botTitle,
  );

  static TextStyle botTitle000Size30Fw800FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 30,
    fontWeight: FontWeight.w800,
    color: ColorConstants.botTitle,
  );

  static TextStyle botTitle000Size20Fw600FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: ColorConstants.botTitle,
  );

  // graySecond

  static TextStyle graySecondSize14Fw400FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorConstants.graySecond,
  );

  // titleSearch
  static TextStyle titleSearchSize12Fw400FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorConstants.titleSearch,
  );

  static TextStyle titleSearchSize14Fw400FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorConstants.titleSearch,
  );

  static TextStyle titleSearchSize16Fw400FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorConstants.titleSearch,
  );

  static TextStyle graySubSize16Fw400FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorConstants.titleSearch,
  );

  // blue
  static TextStyle blue000Size16Fw400FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorConstants.blue,
  );

  static TextStyle blue000Size14Fw400FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorConstants.blue,
  );

  static TextStyle blue000Size14Fw600FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: ColorConstants.blue,
  );

  static TextStyle blue000Size12Fw400FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorConstants.blueSecond,
  );

  static TextStyle blueSize16Fw400FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorConstants.blueSecond,
  );

  // gray
  static TextStyle graySize16Fw400FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorConstants.gray,
  );

  static TextStyle graySize14Fw400FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorConstants.gray,
  );

  static TextStyle graySecondSize12Fw400FfMont = const TextStyle(
    fontFamily: FontFamily.mont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorConstants.graySecond,
  );
}
