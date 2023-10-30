import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// ignore: deprecated_member_use
MediaQueryData mediaQueryData = MediaQueryData.fromView(ui.window);

// ignore: constant_identifier_names
const num FIGMA_DESIGN_WIDTH = 360;
// ignore: constant_identifier_names
const num FIGMA_DESIGN_HEIGHT = 800;
// ignore: constant_identifier_names
const num FIGMA_DESIGN_STATUS_BAR = 0;

get _width {
  return mediaQueryData.size.width;
}

get _height {
  num statusBar = mediaQueryData.viewPadding.top;
  num bottomBar = mediaQueryData.viewPadding.bottom;
  num screenHeight = mediaQueryData.size.height - statusBar - bottomBar;
  return screenHeight;
}

double getHorizontalSize(double px) {
  return ((px * _width) / FIGMA_DESIGN_WIDTH);
}

double getVerticalSize(double px) {
  return ((px * _height) / (FIGMA_DESIGN_HEIGHT - FIGMA_DESIGN_STATUS_BAR));
}

double getSize(double px) {
  var height = getVerticalSize(px);
  var width = getHorizontalSize(px);
  if (height < width) {
    return height.toDoubleValue();
  } else {
    return width.toDoubleValue();
  }
}

double getFontSize(double px) {
  return getSize(px);
}

extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(toStringAsFixed(fractionDigits));
  }
}
