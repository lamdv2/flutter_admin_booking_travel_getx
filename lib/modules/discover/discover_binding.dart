import 'package:doan_clean_achitec/modules/discover/discover_controller.dart';
import 'package:get/get.dart';

class DiscoverBinding implements Bindings{
  @override
  void dependencies() {
    Get.put<DiscoverController>(DiscoverController());
  }

}