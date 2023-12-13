import 'package:get/get.dart';

import 'user_in_tour_controller.dart';


class UserInTourBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<UserInTourController>(UserInTourController());
  }
}
