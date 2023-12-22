import 'package:cloud_firestore/cloud_firestore.dart';

class TourModel {
  final String? idTour;
  final String nameTour;
  final String? description;
  final String? idCity;
  final Timestamp? startDate;
  final Timestamp? endDate;
  final double? price;
  final List<String>? images;
  final String? duration;
  final String? accommodation;
  final List<String>? itinerary;
  final List<String>? includedServices;
  final List<String>? excludedServices;
  final double? reviews;
  final double? rating;
  bool active;
  final String? status;
  final List<String>? specialOffers;
  final double? type;
  final String? imgqr;
  final String? location;

  TourModel({
    this.idTour,
    required this.nameTour,
    this.description,
    this.idCity,
    this.startDate,
    this.endDate,
    this.price,
    this.images,
    this.duration,
    this.accommodation,
    this.itinerary,
    this.includedServices,
    this.excludedServices,
    this.reviews,
    this.rating,
    required this.active,
    this.specialOffers,
    this.status,
    this.type,
    this.imgqr,
    this.location,
  });

  factory TourModel.fromJson(DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data()!;
    return TourModel(
      idTour: document.id,
      nameTour: json['nameTour'],
      description: json['description'],
      idCity: json['idCity'],
      startDate: _parseTimestamp(json['startDate']),
      endDate: _parseTimestamp(json['endDate']),

      // ignore: prefer_null_aware_operators
      price: json['price'] != null ? json['price'].toDouble() : null,
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      duration: json['duration'],
      accommodation: json['accommodation'],
      itinerary: json['itinerary'] != null
          ? List<String>.from(json['itinerary'])
          : null,
      includedServices: json['includedServices'] != null
          ? List<String>.from(json['includedServices'])
          : null,
      excludedServices: json['excludedServices'] != null
          ? List<String>.from(json['excludedServices'])
          : null,
      // ignore: prefer_null_aware_operators
      reviews: json['reviews'] != null ? json['reviews'].toDouble() : null,
      // ignore: prefer_null_aware_operators
      rating: json['rating'] != null ? json['rating'].toDouble() : null,
      active: json['active'] ?? false,
      specialOffers: json['specialOffers'] != null
          ? List<String>.from(json['specialOffers'])
          : null,
      status: json['status'],
      // ignore: prefer_null_aware_operators
      type: json['type'] != null ? json['type'].toDouble() : null,
      imgqr: json['imgqr'],
      location: json['location'],
    );
  }

  factory TourModel.fromJsonSearch(Map<String, dynamic> json) {
    return TourModel(
      idTour: json['idTour'],
      nameTour: json['nameTour'],
      description: json['description'],
      idCity: json['idCity'],
      startDate: _parseTimestamp(json['startDate']),
      endDate: _parseTimestamp(json['endDate']),
      // ignore: prefer_null_aware_operators
      price: json['price'] != null ? json['price'].toDouble() : null,
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      duration: json['duration'],
      accommodation: json['accommodation'],
      itinerary: json['itinerary'] != null
          ? List<String>.from(json['itinerary'])
          : null,
      includedServices: json['includedServices'] != null
          ? List<String>.from(json['includedServices'])
          : null,
      excludedServices: json['excludedServices'] != null
          ? List<String>.from(json['excludedServices'])
          : null,
      // ignore: prefer_null_aware_operators
      reviews: json['reviews'] != null ? json['reviews'].toDouble() : null,
      // ignore: prefer_null_aware_operators
      rating: json['rating'] != null ? json['rating'].toDouble() : null,
      active: json['active'] ?? false,
      specialOffers: json['specialOffers'] != null
          ? List<String>.from(json['specialOffers'])
          : null,
      status: json['status'],
      type: json['type'],
      imgqr: json['imgqr'],
      location: json['location'],
    );
  }

  static Timestamp? _parseTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return timestamp;
    } else if (timestamp is String) {
      return Timestamp.fromDate(DateTime.parse(timestamp));
    }
    return null;
  }

  toJson() {
    return {
      'idTour': idTour,
      'nameTour': nameTour,
      'description': description,
      'idCity': idCity,
      'startDate':
          startDate != null ? startDate!.toDate().toIso8601String() : null,
      'endDate': endDate != null ? endDate!.toDate().toIso8601String() : null,
      'price': price,
      'images': images,
      'duration': duration,
      'accommodation': accommodation,
      'itinerary': itinerary,
      'includedServices': includedServices,
      'excludedServices': excludedServices,
      'reviews': reviews,
      'rating': rating,
      'active': active,
      'specialOffers': specialOffers,
      'status': status,
      'type': type,
      'imgqr': imgqr,
      'location': location,
    };
  }
}
