import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String? id;
  final String? idUser;
  final String? fcmToken;

  NotificationModel({
    this.id,
    this.idUser,
    this.fcmToken,
  });

  factory NotificationModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;
    return NotificationModel(
      id: document.id,
      idUser: json['idUser'],
      fcmToken: json['fcmToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idUser': idUser,
      'fcmToken': fcmToken,
    };
  }
}
