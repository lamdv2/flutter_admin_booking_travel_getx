import 'package:doan_clean_achitec/modules/pay/pay_controller.dart';
import 'package:get/get.dart';

class PayBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PayController>(PayController());
  }
}
