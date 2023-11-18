// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrCodeController extends GetxController {
  DateTime? currentBackPressTime;

  QRViewController? controllerQRcodeView;

  final RxBool isFlashOn = false.obs;
  RxBool hasScanned = false.obs;
  bool isScanning = false;
  String scannedText = "";

  void onQRViewCreated(
      QRViewController qrViewController, BuildContext context) {
    controllerQRcodeView = qrViewController;
    qrViewController.scannedDataStream.listen(
      (scanData) async {
        if (!isScanning) {
          String qrCodeData = (scanData.code ?? "").trim();
        }
      },
    );
  }

  void toggleFlashLight() {
    isFlashOn.toggle();
    final qrController = controllerQRcodeView;
    if (qrController != null) {
      qrController.toggleFlash();
    }
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      Get.snackbar('Request Permission', 'No Permisstion');
    }
  }
}
