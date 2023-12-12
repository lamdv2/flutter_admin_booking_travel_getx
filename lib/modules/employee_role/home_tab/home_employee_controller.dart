// ignore_for_file: library_private_types_in_public_api

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/employee/employee.dart';
import 'package:doan_clean_achitec/models/employee/tour_guide.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/models/tour/type_service_search.dart';
import 'package:doan_clean_achitec/modules/profile/edit_profile.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:doan_clean_achitec/shared/constants/local_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class HomeEmployeeController extends GetxController {
  final _db = FirebaseFirestore.instance;

  final nameTourController = TextEditingController();
  final descriptionController = TextEditingController();
  final startAtController = TextEditingController();
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
  final typeTourController = TextEditingController();
  final activeController = TextEditingController();
  final statusController = TextEditingController();
  final specialOffersController = TextEditingController();

  Rx<String> selectedValue = '50HCM'.obs;
  Rx<String> selectedValueTypeTour = 'Places to visit and sightsee'.obs;
  Rx<String> selectedValueSaleTour = 'Popular'.obs;
  final getListTour = Rxn<List<TourModel>>();
  final filterListTourData = Rxn<List<TourModel>>();

  TextEditingController searchController = TextEditingController();

  Rx<List<AssetEntity>> imageTours = Rx([]);
  final listImageToursChecked = Rxn<List<Uint8List>>([]);
  final listImageTours = Rxn<List<String>>([]);
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final listEmployeeOfTour = Rxn<List<EmployeeModel>>([]);

  @override
  void onInit() {
    createTypeService();
    getAllTourModelData();
    super.onInit();
  }

  Future<void> filterListTourByName(String keyword) async {
    if (keyword.isEmpty) {
      getListTour.value = filterListTourData.value;
    } else {
      getListTour.value = filterListTourData.value
          ?.where(
              (listTour) => _containsAllKeywords(listTour.nameTour, keyword))
          .toList();
    }
  }

  bool _containsAllKeywords(String tourName, String keyword) {
    List<String> searchTerms = keyword.toLowerCase().split(' ');

    return searchTerms.every((term) => tourName.toLowerCase().contains(term));
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
    String childName,
    List<Uint8List> files,
  ) async {
    List<String> uploadPaths = [];
    List<String> temporaryPaths = [];

    for (Uint8List file in files) {
      var uuid = const Uuid();
      Reference ref =
          _storage.ref().child('tours').child(childName).child(uuid.v4());

      SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
      UploadTask uploadTask = ref.putData(file, metadata);

      await uploadTask;

      String imageHttp = await getImageStorage(ref.fullPath);

      temporaryPaths.add(imageHttp);
    }

    uploadPaths.addAll(temporaryPaths);
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
          backgroundColor: ColorConstants.blue.withOpacity(.05),
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
    startAtController.clear();
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
    typeTourController.clear();
    activeController.clear();
    statusController.clear();
    specialOffersController.clear();
    listImageTours.value?.clear();
    listImageToursChecked.value?.clear();
    imageTours.value.clear();

    selectedValue = '50HCM'.obs;
    selectedValueTypeTour = 'Places to visit and sightsee'.obs;
    selectedValueSaleTour = 'Popular'.obs;
    imageTours.value = [];
    listImageToursChecked.value = [];
    listImageTours.value = [];
  }

  Future<bool> onWillPop(BuildContext context) {
    showBottomSheet(context);
    return Future.value(true);
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 80,
              height: 8,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(200)),
            ),
            const CustomBottomSheet(),
          ],
        );
      },
    );
  }

  // Refresh Tour List
  Future<void> refreshTourList() async {
    getAllTourModelData();
  }

  // Get All Tour
  Future<void> getAllTourModelData() async {
    String emailEmpl = await LocalStorageHelper.getValue("emailEmployee") ?? "";
    final tourSnapshot = await _db.collection('tourModel').get();

    List<TourModel> tourModel = [];

    for (var tourDoc in tourSnapshot.docs) {
      TourModel tour = TourModel.fromJson(tourDoc);

      final tourGuideSnapshot = await _db
          .collection('tourModel')
          .doc(tour.idTour)
          .collection('tourguide')
          .get();

      for (var elmTourGuide in tourGuideSnapshot.docs) {
        TourGuideModel tourGuideModel = TourGuideModel.fromJson(elmTourGuide);
        final employeeSnapshot = await _db
            .collection('employee')
            .doc(tourGuideModel.employeeId)
            .get();

        final employeeList = EmployeeModel.fromJson(employeeSnapshot);

        if (employeeList.email == emailEmpl) {
          tourModel.add(tour);
        }
      }
    }

    getListTour.value = tourModel;
    filterListTourData.value = tourModel;
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

  // Deactive Tour
  Future<void> deActiveTour(TourModel deActiveTour) async {
    try {
      deActiveTour.active = false;
      await _db
          .collection('tourModel')
          .doc(deActiveTour.idTour)
          .update(deActiveTour.toJson());
    } catch (e) {
      throw Exception("Error updating tour: $e");
    }
  }

  // Deactive Tour
  Future<void> activeTour(TourModel activeTour) async {
    try {
      activeTour.active = true;
      await _db
          .collection('tourModel')
          .doc(activeTour.idTour)
          .update(activeTour.toJson());
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

      // ignore: unnecessary_null_comparison
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

  // type tour
  final Rxn<List<TypeServiceSearch>> listTypeSearchService =
      Rxn<List<TypeServiceSearch>>([]);

  void createTypeService() {
    listTypeSearchService.value = [
      TypeServiceSearch(
        isCheck: false,
        typeNub: 0,
        valueType: 'Places to visit and sightsee',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 1,
        valueType: 'Historical sites',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 2,
        valueType: 'Sports events',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 3,
        valueType: 'Sports event',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 4,
        valueType: 'Entertainment',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 5,
        valueType: 'Adventure activities & extreme sports',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 6,
        valueType: 'Farm tourism',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 7,
        valueType: 'Underwater activities',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 8,
        valueType: 'Cultural experience',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 9,
        valueType: 'Half day tour/Day tour',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 10,
        valueType: 'Multi-day tour',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 11,
        valueType: 'Retaurant',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 12,
        valueType: 'Desserts & drinks',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 13,
        valueType: 'Hotel',
      ),
      TypeServiceSearch(
        isCheck: false,
        typeNub: 14,
        valueType: 'Travel equipment & related services',
      ),
    ];
  }

  double typeTourIndex(String value) {
    if (listTypeSearchService.value != null) {
      for (var item in listTypeSearchService.value!) {
        if (item.valueType == value) {
          return item.typeNub;
        }
      }
    }
    return -1;
  }

  String calculateDaysDifference(Timestamp startDate, Timestamp endDate) {
    DateTime startDateTime = startDate.toDate();
    DateTime endDateTime = endDate.toDate();

    Duration difference = endDateTime.difference(startDateTime);

    return (difference.inDays + 1).toString();
  }

  Future<List<EmployeeModel>> getListEmployee(String idTour) async {
    try {
      final snapShot = await _db
          .collection('tourModel')
          .doc(idTour)
          .collection('tourguide')
          .get();

      List<EmployeeModel> listEmployeeData = [];

      for (var doc in snapShot.docs) {
        String employeeId = doc.get('employeeId');

        var employeeDoc =
            await _db.collection('employee').doc(employeeId).get();

        if (employeeDoc.exists) {
          var employeeModel = EmployeeModel.fromJson(employeeDoc);

          listEmployeeData.add(employeeModel);
        } else {}
      }

      return listEmployeeData;
    } catch (e) {
      rethrow;
    }
  }
}

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset('assets/images/json/lt_exit_app.json', height: 200),
        GestureDetector(
          onTap: () {
            SystemNavigator.pop();
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: const Text(
              'Press to exit app',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
