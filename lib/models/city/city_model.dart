import 'package:cloud_firestore/cloud_firestore.dart';

class CityModel {
  final String? id;
  final String? idCity;
  final String nameCity;
  final String? descriptionCity;
  final String? imageCity;

  CityModel({
    this.id,
    this.idCity,
    required this.nameCity,
    this.descriptionCity,
    this.imageCity,
  });

  factory CityModel.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;
    return CityModel(
      id: document.id,
      idCity: json['idCity'],
      nameCity: json['nameCity'],
      descriptionCity: json['descriptionCity'],
      imageCity: json['imageCity'],
    );
  }

  toJson() {
    return {
      'id': id,
      'idCity': idCity,
      'nameCity': nameCity,
      'descriptionCity': descriptionCity,
      'imageCity': imageCity,
    };
  }
}
