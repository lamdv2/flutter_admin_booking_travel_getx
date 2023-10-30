import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AdminController extends GetxController {
  final _db = FirebaseFirestore.instance;

  final nameTourController = TextEditingController();
  final descriptionController = TextEditingController();
  final idCityController = TextEditingController();
  final startDateController = TextEditingController();
  late final endDateController = TextEditingController();
  final priceController = TextEditingController();
  final imagesController = TextEditingController();
  final durationController = TextEditingController();
  final accommodationController = TextEditingController();
  final itineraryController = TextEditingController();
  final includedServicesController = TextEditingController();
  final excludedServicesController = TextEditingController();
  final reviewsController = TextEditingController();
  final ratingController = TextEditingController();
  final activeController = TextEditingController();
  final statusController = TextEditingController();
  final specialOffersController = TextEditingController();

  Rx<String> selectedValue = '50HCM'.obs;
  final getListTour = Rxn<List<TourModel>>();
  final filterListTourData = Rxn<List<TourModel>>();

  TextEditingController searchController = TextEditingController();

  Rx<List<AssetEntity>> imageTours = Rx([]);
  final listImageToursChecked = Rxn<List<Uint8List>>([]);
  final listImageTours = Rxn<List<String>>([]);
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> filterListTourByName(String keyword) async {
    if (keyword.isEmpty) {
      getListTour.value = filterListTourData.value;
    } else {
      getListTour.value = filterListTourData.value
          ?.where(
            (listTour) => listTour.nameTour.toLowerCase().contains(
                  keyword.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  Future<List<Uint8List>> assetEntitiesToUint8Lists(
      List<AssetEntity> assetEntities) async {
    List<Uint8List> resultList = [];

    for (AssetEntity assetEntity in assetEntities) {
      final file = await assetEntity.originFile;
      if (file != null) {
        List<int> bytes = await file.readAsBytes();
        resultList.add(Uint8List.fromList(bytes));
      } else {
        throw Exception('Failed to read asset data');
      }
    }

    return resultList;
  }

  Future<List<String>> uploadImagesToStorage(
      String childName, List<Uint8List> files) async {
    List<String> uploadPaths = [];

    for (Uint8List file in files) {
      var uuid = const Uuid();
      Reference ref =
          _storage.ref().child('tours').child(childName).child(uuid.v4());
      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snapshot = await uploadTask;

      uploadPaths.add(ref.fullPath);
    }

    return uploadPaths;
  }

  Future<void> createTour(TourModel tourModel) async {
    await FirebaseFirestore.instance
        .collection('tourModel')
        .add(tourModel.toJson())
        .whenComplete(
      () {
        Get.snackbar(
          "Success",
          "New tour added!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorConstants.blue.withOpacity(.1),
          colorText: ColorConstants.blue,
        );
        clearController();
      },
      // ignore: body_might_complete_normally_catch_error
    ).catchError((error) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try again!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorConstants.red.withOpacity(.1),
        colorText: ColorConstants.red,
      );
    });
  }

  String timestampToString(Timestamp timestamp) {
    try {
      DateTime dateTime = timestamp.toDate();

      String formattedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime);

      return formattedDate;
    } catch (e) {
      return 'Lỗi: $e';
    }
  }

  void clearController() {
    nameTourController.clear();
    descriptionController.clear();
    idCityController.clear();
    startDateController.clear();
    endDateController.clear();
    priceController.clear();
    imagesController.clear();
    durationController.clear();
    accommodationController.clear();
    itineraryController.clear();
    includedServicesController.clear();
    excludedServicesController.clear();
    reviewsController.clear();
    ratingController.clear();
    activeController.clear();
    statusController.clear();
    specialOffersController.clear();
  }

  // Refresh Tour List

  Future<void> refreshTourList() async {
    getAllTourModelData();
  }

  // Get All Tour

  Future<void> getAllTourModelData() async {
    final snapShot = await _db.collection('tourModel').get();
    final listTourData =
        snapShot.docs.map((doc) => TourModel.fromJson(doc)).toList();

    getListTour.value = listTourData;
    filterListTourData.value = listTourData;
  }

  Future<TourModel> getTourDetailsById(String id) async {
    final snapShot = await _db.collection('tourModel').doc(id).get();

    if (snapShot.exists) {
      return TourModel.fromJson(snapShot);
    } else {
      throw Exception("Error: not exists!!!");
    }
  }

  Future<void> editTourDetailsById(TourModel updatedTour) async {
    try {
      await _db
          .collection('tourModel')
          .doc(updatedTour.idTour)
          .update(updatedTour.toJson());
    } catch (e) {
      throw Exception("Error updating tour: $e");
    }
  }

  // Delete Tour By Id

  Future<void> deleteTourById(String idTour) async {
    try {
      await _db.collection('tourModel').doc(idTour).delete();
    } catch (e) {
      throw Exception("Error updating tour: $e");
    }
  }

  // format datetime

  Timestamp formatDateTime(String startDateText) {
    DateTime startDate;

    try {
      final inputFormat = DateFormat('dd MMM yyyy');
      startDate = inputFormat.parse(startDateText);
    } catch (e) {
      startDate = DateTime.now();
    }
    return Timestamp.fromDate(startDate);
  }

  Future<void> pickImages(BuildContext context) async {
    final resultList = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: 10,
        selectedAssets: imageTours.value,
        requestType: RequestType.image,
      ),
    );
    if (resultList != null && resultList.isNotEmpty) {
      imageTours.value = resultList;
    }
  }

  Future<String> getImageStorage(String nameImage) async {
    Reference ref = FirebaseStorage.instance.ref().child(nameImage);
    try {
      final result = await ref.getMetadata();

      if (result != null) {
        String downloadUrl = await ref.getDownloadURL();
        return downloadUrl;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }
}
