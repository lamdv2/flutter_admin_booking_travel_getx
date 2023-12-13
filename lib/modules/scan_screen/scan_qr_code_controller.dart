// ignore_for_file: deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/history/history_model.dart';
import 'package:doan_clean_achitec/modules/employee_role/user_in_tour/user_in_tour_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../shared/constants/string_constants.dart';

class ScanQrCodeController extends GetxController {
  final _db = FirebaseFirestore.instance;
  DateTime? currentBackPressTime;

  QRViewController? controllerQRcodeView;

  final RxBool isFlashOn = false.obs;
  RxBool hasScanned = false.obs;
  final isScanning = RxnBool(false);
  String scannedText = "";

  UserInTourController userInTourController = Get.put(UserInTourController());

  void onQRViewCreated(
      QRViewController qrViewController, BuildContext context) {
    controllerQRcodeView = qrViewController;
    qrViewController.scannedDataStream.listen(
      (scanData) async {
        if (isScanning.value == false) {
          String qrCodeData = (scanData.code ?? "").trim();
          checkScan(qrCodeData, context);
          isScanning.value = true;
        }
      },
    );
  }

  void checkScan(String idHistory, BuildContext context) async {
    final docRef = _db.collection('historyModel').doc(idHistory);

    try {
      final snapshot = await docRef.get();
      final historyData = HistoryModel.fromJson(snapshot);

      if (snapshot.exists) {
        if (historyData.isCheckUserParti == false) {
          // ignore: use_build_context_synchronously
          await confirmLogoutDialog(context, "Success", "Check success",
              () async {
            await docRef.update({'isCheckUserParti': true});
            final historyData = HistoryModel.fromJson(snapshot);
            userInTourController.getUserBooking(historyData.idTour ?? "");
            isScanning.value = false;
            Get.back();
            Get.back();
          });
        } else {
          // ignore: use_build_context_synchronously
          await confirmLogoutDialog(
              context, "Warning", "This qr code has already been scanned",
              () async {
            await docRef.update({'isCheckUserParti': true});
            final historyData = HistoryModel.fromJson(snapshot);
            userInTourController.getUserBooking(historyData.idTour ?? "");
            isScanning.value = false;
            Get.back();
            Get.back();
          });
        }
      } else {
        // ignore: use_build_context_synchronously
        await confirmLogoutDialog(context, "Error", "Does not exist", () async {
          isScanning.value = false;
          Get.back();
          Get.back();
        });
        Get.snackbar('Error!!!', 'Does not exist!!!', colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error!!!', 'An error occurred while updating!!!',
          colorText: Colors.white);
    }
  }

  Future<void> confirmLogoutDialog(BuildContext context, String title,
      String content, Function() function) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: Get.back,
              child: Text(
                StringConst.cancel.tr,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: function,
              child: Text(
                StringConst.ok.tr,
              ),
            ),
          ],
        );
      },
    );
  }

  // void checkScan(String idHistory) async {
  //   final snapshot = await _db.collection('historyModel').doc(idHistory).get();

  //   if (snapshot.exists) {
  //     Get.snackbar('Success!!!', 'Checked!!!', colorText: Colors.white);
  //     final historyModelData = HistoryModel.fromJson(snapshot);
  //     historyModelData.isCheckUserParti = true;
  //   } else {
  //     Get.snackbar('Error!!!', 'Does not exist!!!', colorText: Colors.white);
  //   }
  // }

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
