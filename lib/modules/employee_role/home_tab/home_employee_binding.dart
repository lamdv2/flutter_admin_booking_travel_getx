import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:get/get.dart';

import 'home_employee_controller.dart';

class HomeEmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeEmployeeController>(HomeEmployeeController());
    Get.put<HomeController>(HomeController());
  }
}
