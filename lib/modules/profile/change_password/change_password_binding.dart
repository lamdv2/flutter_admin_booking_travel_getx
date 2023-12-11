import 'package:doan_clean_achitec/modules/profile/change_password/change_password_controller.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:get/get.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ChangePasswordController>(ChangePasswordController());
    Get.lazyPut(() => ProfileController());
  }
}
