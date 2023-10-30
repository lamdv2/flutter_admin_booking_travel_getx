import 'package:get/get.dart';

import 'history_tour_controller.dart';

class HistoryTourBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HistoryTourController>(HistoryTourController());
  }
}
