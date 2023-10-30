import 'package:doan_clean_achitec/modules/hotel_detail/hotel_detail_controller.dart';
import 'package:get/get.dart';

class HotelDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HotelDetailController>(HotelDetailController());
  }
}
