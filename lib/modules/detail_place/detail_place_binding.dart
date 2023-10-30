import 'package:doan_clean_achitec/modules/detail_place/detail_place_controller.dart';
import 'package:get/get.dart';

class DetailPlaceBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<DetailPlaceController>(DetailPlaceController());
  }

}