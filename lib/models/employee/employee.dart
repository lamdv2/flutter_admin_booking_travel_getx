import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeModel {
  final String? id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String phoneNub;
  final String? location;
  final bool isActive;

  EmployeeModel({
    this.id,
    required this.email,
    this.firstName,
    this.lastName,
    required this.phoneNub,
    this.location,
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
      'isActive': isActive,
    };
  }

  factory EmployeeModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return EmployeeModel(
      id: document.id,
      email: data['email'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      phoneNub: data['phoneNub'],
      location: data['location'],
      isActive: data['isActive'],
    );
  }
}
