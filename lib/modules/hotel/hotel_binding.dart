import 'package:doan_clean_achitec/modules/hotel/hotel_controller.dart';
import 'package:get/get.dart';

class HotelBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HotelController>(HotelController());
  }
}
