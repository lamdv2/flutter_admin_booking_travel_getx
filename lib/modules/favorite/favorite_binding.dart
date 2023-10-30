import 'package:doan_clean_achitec/modules/favorite/favorite_controller.dart';
import 'package:get/get.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FavoriteController>(FavoriteController());
  }
}
