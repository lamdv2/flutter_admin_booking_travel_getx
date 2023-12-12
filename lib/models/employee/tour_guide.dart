import 'package:cloud_firestore/cloud_firestore.dart';

class TourGuideModel {
  final String? id;
  final String employeeId;

  TourGuideModel({
    this.id,
    required this.employeeId,
  });

  toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
    };
  }

  factory TourGuideModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return TourGuideModel(
      id: document.id,
      employeeId: data['employeeId'] ?? '',
    );
  }
}
