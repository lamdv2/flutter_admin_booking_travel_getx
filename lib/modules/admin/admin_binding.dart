import 'package:doan_clean_achitec/modules/admin/admin_controller.dart';
import 'package:get/get.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AdminController>(AdminController());
  }
}
