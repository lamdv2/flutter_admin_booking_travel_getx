import 'package:doan_clean_achitec/modules/room/room.dart';
import 'package:get/get.dart';

class RoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RoomController>(RoomController());
  }
}
