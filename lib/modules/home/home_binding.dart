import 'package:doan_clean_achitec/modules/auth/user_controller.dart';
import 'package:doan_clean_achitec/modules/home/home_controller.dart';
import 'package:get/get.dart';

import '../employee_role/home_tab/home_employee_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<HomeEmployeeController>(HomeEmployeeController());
    Get.put<UserController>(UserController());
  }
}
