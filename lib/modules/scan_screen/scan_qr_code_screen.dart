// ignore_for_file: deprecated_member_use

import 'package:doan_clean_achitec/modules/scan_screen/scan_qr_code_controller.dart';
import 'package:doan_clean_achitec/shared/constants/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../shared/utils/size_utils.dart';
import '../../shared/constants/colors.dart';

class ScanQRCodeScreen extends GetView<ScanQrCodeController> {
  ScanQRCodeScreen({super.key});

  final ScanQrCodeController controller = Get.put(ScanQrCodeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildQrView(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 6),
            child: Column(
              children: [
                Text(
                  'Scan QR Code',
                  style: AppStyles.white000Size24Fw400FfMont,
                  textAlign: TextAlign.center,
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            controller.isFlashOn.value
                                ? Icons.flash_on
                                : Icons.flash_off,
                          ),
                          onPressed: () => controller.toggleFlashLight(),
                        ),
                        SizedBox(
                          width: getSize(20),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? size.height * 0.4
        : size.height * 0.4;
    return QRView(
      key: qrKey,
      onQRViewCreated: (QRViewController qrViewController) {
        controller.onQRViewCreated(qrViewController, context);
      },
      overlay: QrScannerOverlayShape(
        borderColor: ColorConstants.primaryButton,
        borderRadius: 5,
        borderLength: 20,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) =>
          controller.onPermissionSet(context, ctrl, p),
    );
  }
}
