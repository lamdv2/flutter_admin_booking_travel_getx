import 'package:doan_clean_achitec/modules/auth/auth_controller.dart';
import 'package:doan_clean_achitec/modules/profile/profile_controller.dart';
import 'package:doan_clean_achitec/modules/tour/tour_controller.dart';
import 'package:get/get.dart';

class TourBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TourController>(TourController());
    Get.put<ProfileController>(ProfileController());
    Get.put<AuthController>(AuthController());
  }
}
