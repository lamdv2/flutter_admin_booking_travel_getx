import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  final String? id;
  final String? idUser;
  final String? idTour;
  final bool isActive;
  final Timestamp? bookingDate;
  String? status;

  HistoryModel({
    this.id,
    this.idUser,
    this.idTour,
    this.bookingDate,
    this.status,
    required this.isActive,
  });

  factory HistoryModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;
    return HistoryModel(
      id: document.id,
      idUser: json['idUser'],
      idTour: json['idTour'],
      bookingDate:
          json['bookingDate'] != null ? json['bookingDate'] as Timestamp : null,
      status: json['status'],
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idUser': idUser,
      'idTour': idTour,
      'bookingDate': bookingDate,
      'status': status,
      'isActive': isActive,
    };
  }
}
