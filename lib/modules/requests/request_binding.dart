import 'package:doan_clean_achitec/modules/requests/request.dart';
import 'package:get/get.dart';

class RequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RequestController>(RequestController());
  }
}
