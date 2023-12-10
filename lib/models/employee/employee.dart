import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeModel {
  final String? id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String phoneNub;
  final String? location;
  final String? imgAvatar;
  final String passWord;
  final bool isActive;

  EmployeeModel({
    this.id,
    required this.email,
    this.firstName,
    this.lastName,
    required this.phoneNub,
    this.location,
    this.imgAvatar,
    required this.passWord,
    required this.isActive,
  });

  toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNub': phoneNub,
      'location': location,
      'imgAvatar': imgAvatar,
      'passWord': passWord,
      'isActive': isActive,
    };
  }

  factory EmployeeModel.fromJson(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return EmployeeModel(
      id: document.id,
      email: data['email'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      phoneNub: data['phoneNub'] ?? '',
      location: data['location'] ?? '',
      imgAvatar: data['imgAvatar'] ?? '',
      passWord: data['passWord'] ?? '',
      isActive: data['isActive'] ?? false,
    );
  }

  factory EmployeeModel.fromQueryJson(QueryDocumentSnapshot<Object?> document) {
    final data = document.data()! as Map<String, dynamic>;
    return EmployeeModel(
      id: document.id,
      email: data['email'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      phoneNub: data['phoneNub'] ?? '',
      location: data['location'] ?? '',
      imgAvatar: data['imgAvatar'] ?? '',
      passWord: data['passWord'] ?? '',
      isActive: data['isActive'] ?? false,
    );
  }
}
