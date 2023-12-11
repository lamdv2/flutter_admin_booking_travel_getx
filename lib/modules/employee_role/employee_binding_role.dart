import 'package:get/get.dart';

import 'employee_controller_role.dart';

class EmployeeRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<EmployeeRoleController>(EmployeeRoleController());
  }
}
