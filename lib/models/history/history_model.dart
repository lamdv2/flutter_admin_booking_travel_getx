import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  final String? id;
  final String? idUser;
  final String? idTour;
  final bool isActive;
  final Timestamp? bookingDate;
  String? status;
  double? adult;
  double? children;
  double? totalPrice;

  HistoryModel({
    this.id,
    this.idUser,
    this.idTour,
    this.bookingDate,
    this.status,
    this.adult,
    this.children,
    this.totalPrice,
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
      adult: json['adult']?.toDouble(),
      children: json['children']?.toDouble(),
      totalPrice: json['totalPrice']?.toDouble(),
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
      'adult': adult,
      'children': children,
      'totalPrice': totalPrice,
    };
  }
}
