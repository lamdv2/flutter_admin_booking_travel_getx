import 'package:flutter/material.dart';

class ColorConstants {
  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static const Color tipColor = Color(0xFFB6B6B6);
  static const Color red = Color.fromARGB(255, 253, 38, 0);
  static const Color yellow = Color(0xFFFFAF34);

  static const Color lightScaffoldBackgroundColor = Color(0xFFF9F9F9);
  static const Color lightSubScaffoldBackgroundColor = Color(0xFFFAFAFA);
  static const Color primaryButton = Color(0xFF4166d8);
  static const Color lightGray = Color(0xFFF6F6F6);
  static const Color grayTextField = Color(0xFFf2f5fc);
  static const Color secondBackground = Color(0xFFf4f7fc);

  static const Color secondaryAppColor = Color(0xFF22DDA6);
  static const Color green = Color(0xFF3E9D9D);
  static const Color btnGradient = Color(0xFF43B1C4);

  static const Color blue = Color(0xFF2185D5);
  static const Color blueSecond = Color(0xFF237CEF);
  static const Color primaryColor = Color(0xFF6155CC);
  static const Color nextColor = Color(0xFF1563EF);

  static const Color gray = Color(0xFFD0D0D0);
  static const Color graySub = Color(0xFF3A4750);
  static const Color graySecond = Color(0xFF878787);
  static const Color darkGray = Color(0xFF9F9F9F);
  static const Color dividerColor = Color(0xFFE5E7EB);
  static const Color text1Color = Color(0xFF323B4B);
  static const Color subText = Color(0xFFEAEAEA);
  static const Color botTitle = Color(0xFF313131);
  static const Color secondButton = Color(0xFF006B56);
  static const Color titleSearch = Color(0xFF636363);
  static const Color titleSub = Color(0xFF1B1D1E);
  static Color black = const Color(0xFF000000);

  static const Color white = Color(0xFFFFFFFF);
  static const Color secondColor = Color.fromARGB(255, 96, 24, 251);
  static const Color restau = Color(0xFF5161F1);
  static const Color cars = Color(0xFF3EC8BC);
  static const Color hotels = Color(0xFFFF4760);
  static const Color flights = Color(0xFFFE9C5E);
  static const Color btnCanCel = Color(0xFFD9D9D9);
  static Color blur = const Color(0xFF121212).withOpacity(0.1);
  static Color transparent = const Color.fromARGB(0, 18, 18, 18);

  static Color darkScaffoldBackgroundColor = hexToColor('#2F2E2E');
  static const lightBlueNon = Color(0x48CAE7);

  // Light theme
  // Status bar
  static const Color lightStatusBar =  Color(0xFFE0E0E0);
  // App bar
  static const Color lightAppBar =  Color(0xFFF5F5F5);
  // Background
  static const Color lightBackground =  Color(0xFFFAFAFA);
  // Cards
  static Color? lightCard = white;

  // Dark theme
  // Status bar
  static Color darkStatusBar = black;
  // App bar
  static const Color darkAppBar =  Color(0xFF212121);
  // Background
  static const Color darkBackground =  Color(0xFF303030);
  // Cards
  static const Color darkCard =  Color(0xFF424242);

  // flutter flow
  static const Color accent1 = Color(0xFF616161);
  static const Color accent2 = Color(0xFF757575);
  static const Color primary = Color(0xFF22282F);
  static const Color primaryBackground = Color(0xFFF1F4F8);
  static const Color bgrLight = Color(0xFFf2f2f2);
  static const Color secondary = Color(0xFF4B39EF);
  static const Color error = Color(0xFFE21C3D);
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class Gradients {
  static const Gradient defaultGradientBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      ColorConstants.btnGradient,
      ColorConstants.nextColor,
    ],
  );

  static const Gradient defaultGradientButtonCancel = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    colors: [
      ColorConstants.dividerColor,
      ColorConstants.btnCanCel,
    ],
  );

  static const Gradient defaultGradientButton = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    colors: [
      Gradients.lightBlue1,
      Gradients.lightBlue2,
    ],
  );

  static const lightBlue1 = Color(0xFF449EFF);
  static const lightBlue2 = Color(0xFF1DC7F7);
  static const darkGreyNon = Color(0x22264444);
  static const darkGreyMid = Color(0x3C2B3050);
  static const darkGrey = Color(0xFF222644);
  static const promo1 = Color(0xFF3E60F9);
  static const promo2 = Color(0xFF3A52FF);
}
