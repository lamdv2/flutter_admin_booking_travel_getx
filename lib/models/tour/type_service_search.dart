import 'package:cloud_firestore/cloud_firestore.dart';

class TypeServiceSearch {
  bool isCheck;
  final double typeNub;
  final String valueType;

  TypeServiceSearch({
    required this.isCheck,
    required this.typeNub,
    required this.valueType,
  });

  factory TypeServiceSearch.fromJson(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;
    return TypeServiceSearch(
      isCheck: json['isCheck'] ?? false,
      typeNub: json['typeNub'],
      valueType: json['valueType'],
    );
  }

  String? get tr => null;

  toJson() {
    return {
      'isCheck': isCheck,
      'typeNub': typeNub,
      'valueType': valueType,
    };
  }
}
