import 'package:doan_clean_achitec/modules/auth/auth_controller.dart';
import 'package:get/get.dart';

import 'tour_role_controller.dart';

class TourRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TourRoleController>(TourRoleController());
    Get.put<AuthController>(AuthController());
  }
}
