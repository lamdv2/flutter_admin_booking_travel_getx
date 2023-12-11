import 'package:doan_clean_achitec/modules/scan_screen/scan_qr_code_controller.dart';
import 'package:get/get.dart';

class ScanQrCodeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ScanQrCodeController());
  }
}
