import 'package:doan_clean_achitec/modules/chart/chart.dart';
import 'package:get/get.dart';

class ChartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ChartController>(ChartController());
  }
}
