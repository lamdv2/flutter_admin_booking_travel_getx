import 'package:doan_clean_achitec/modules/auth/user_controller.dart';
import 'package:get/get.dart';

import 'home_controller_role.dart';

class HomeRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeRoleController>(HomeRoleController());
    Get.put<UserController>(UserController());
  }
}
