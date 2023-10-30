import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/history_tour/history_tour.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  final _db = FirebaseFirestore.instance;

  final HistoryTourController historyTourController =
      Get.put(HistoryTourController());

  RxString selectedValue = '50HCM'.obs;

  String convertToDDMM(String inputDate) {
    final parts = inputDate.split('-');
    if (parts.length == 3) {
      final month = parts[1];
      final day = parts[2];
      return '$day/$month';
    }
    return inputDate;
  }

  Future<void> bookingTour(String userId, String tourId, Timestamp bookingDate,
      String status) async {
    if (userId.isEmpty || tourId.isEmpty) {
      Get.snackbar('Error', 'Booking fail !!!');
    } else {
      await _db.collection('historyModel').add({
        'idUser': userId,
        'idTour': tourId,
        'isActive': true,
        'bookingDate': bookingDate,
        'status': status,
      });
      Get.snackbar('Success', 'Booking successfully !!!');

      await historyTourController.getAllTourModelData(userId);
    }
  }
}
