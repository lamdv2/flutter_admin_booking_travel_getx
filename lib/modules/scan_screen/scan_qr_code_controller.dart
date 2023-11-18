// ignore_for_file: deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrCodeController extends GetxController {
  final _db = FirebaseFirestore.instance;
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
          checkScan(qrCodeData);
          isScanning = true;
        }
      },
    );
  }

  void checkScan(String idHistory) async {
    final snapshot = await _db.collection('historyModel').doc(idHistory).get();

    if (snapshot.exists) {
      Get.snackbar('Success!!!', 'Checked!!!', colorText: Colors.white);
    } else {
      Get.snackbar('Error!!!', 'Does not exist!!!', colorText: Colors.white);
    }
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
