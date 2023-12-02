import 'package:doan_clean_achitec/modules/employee/employee_controller.dart';
import 'package:get/get.dart';

class EmployeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EmployeeController>(EmployeeController());
  }
}
