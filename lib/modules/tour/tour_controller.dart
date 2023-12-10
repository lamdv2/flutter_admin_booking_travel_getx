import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/city/city_model.dart';
import 'package:doan_clean_achitec/models/employee/employee.dart';
import 'package:doan_clean_achitec/models/tour/tour_model.dart';
import 'package:doan_clean_achitec/modules/admin/admin_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/widgets/image_full_screen.dart';

class TourController extends GetxController {
  final _db = FirebaseFirestore.instance;
  final AdminController adminController = Get.put(AdminController());

  List<String> detailsHotelList = ["Overview", "Itinerary", "Review & Rating"];

  RxBool isCheckSearch = false.obs;
  RxString idTour = ''.obs;
  final cityModel = Rxn<CityModel>();
  final getListTour = Rxn<List<TourModel>>();
  final filterListTourData = Rxn<List<TourModel>>();
  final cityList = Rxn<List<Map<String, String>>>();
  TextEditingController searchController = TextEditingController();
  final items = Rxn<List<String>>([]);
  final getListTourImages = Rxn<List<String>>([]);
  final listAllEmployee = Rxn<List<EmployeeModel>>([]);
  final listAllEmployeeData = Rxn<List<EmployeeModel>>([]);
  TextEditingController searchEmployeeController = TextEditingController();
  RxList<bool> checkBoxStates = ([false]).obs;

  @override
  void onInit() {
    getAllEmployee();
    super.onInit();
  }

  Future<void> getAllEmployee() async {
    final snapShot = await _db
        .collection('employee')
        .where('isActive', isEqualTo: true)
        .get();
    final listEmployeeData =
        snapShot.docs.map((doc) => EmployeeModel.fromJson(doc)).toList();

    listEmployeeData.sort((a, b) => a.firstName!.compareTo(b.firstName ?? ""));

    listAllEmployee.value = listEmployeeData;
    listAllEmployeeData.value = listEmployeeData;
    checkBoxStates =
        List.generate(listAllEmployee.value?.length ?? 0, (index) => false).obs;
    adminController.refreshTourList();
  }

  // Tour Details Call Firebase
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

  // Refresh Tour List

  Future<void> refreshTourList() async {
    getAllTourModelData();
    getAllCity();
  }

  // Edit Tour

  Future<void> updateTour(TourModel updatedTour) async {
    try {
      final tourRef = _db.collection('tourModel').doc(updatedTour.idTour);
      final tourData = updatedTour.toJson();
      await tourRef.update(tourData);
    } catch (e) {
      throw Exception("Error updating tour: $e");
    }
  }

  // Get All Tour

  Future<void> getAllTourModelData() async {
    final snapShot = await _db.collection('tourModel').get();
    final listTourData =
        snapShot.docs.map((doc) => TourModel.fromJson(doc)).toList();

    getListTour.value = listTourData;
    filterListTourData.value = listTourData;
  }

  Future<void> getAllCity() async {
    final snapShot = await _db.collection('cityModel').get();

    if (snapShot.docs.isNotEmpty) {
      final cityModelById =
          snapShot.docs.map((e) => CityModel.fromJson(e)).toList();

      cityList.value ??= [];
      cityList.value?.clear();

      for (var element in cityModelById) {
        Map<String, String> item = {'${element.idCity}': element.nameCity};
        cityList.value!.add(item);
      }
    }
  }

  // Location intent Map

  Future<void> launchMap(String address) async {
    final query = Uri.encodeComponent(address);
    final url = 'https://www.google.com/maps/search/?api=1&query=$query';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String> getImageStorage(String nameImage) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child(nameImage);
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return '';
    }
  }

  void getUrlImage(List<String> getListImage) async {
    try {
      List<String> links = [];
      for (var e in getListImage) {
        String linkImage = await getImageStorage(e);
        links.add(linkImage);
      }
      getListTourImages.value = links;
      // ignore: empty_catches
    } catch (e) {}
  }

  void showFullImageDialog(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullImageScreen(
          imageUrl: imageUrl,
        ),
      ),
    );
  }

  // Filter List Tour

  // Filter get all
  void getAllTour() {
    getListTour.value = filterListTourData.value;
  }

  void loadCity() {
    if (cityList.value != null) {
      items.value?.clear();
      for (var city in cityList.value!) {
        city.forEach((key, value) {
          items.value?.add(key);
        });
      }
    }
  }

  // Filter by Name Tour
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

  // Filter by State
  Future<void> filterListTourByState(String keyword) async {
    if (keyword.isEmpty) {
      getListTour.value = filterListTourData.value;
    } else {
      getListTour.value = filterListTourData.value
          ?.where(
            (listTour) => listTour.status!.toLowerCase().contains(
                  keyword.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  // Filter by Date

  Future<void> filterListTourByDateStart(String keyword) async {
    if (keyword.isEmpty) {
      getListTour.value = filterListTourData.value;
    } else {
      getListTour.value = filterListTourData.value
          ?.where(
            (listTour) => listTour.startDate.toString().toLowerCase().contains(
                  keyword.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  // Filter by City
  Future<void> filterListTourByCity(String keyword) async {
    if (keyword.isEmpty) {
      getListTour.value = filterListTourData.value;
    } else {
      getListTour.value = filterListTourData.value
          ?.where(
            (listTour) => listTour.idCity!.toLowerCase().contains(
                  keyword.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  String getNameCityById(String cityId) {
    if (cityList.value != null) {
      for (var cityMap in cityList.value!) {
        var key = cityMap.keys.first;

        if (key == cityId) {
          var value = cityMap.values.first;
          return value;
        }
      }
    }
    return '';
  }

  Future<void> setEmployee(String idTour) async {
    try {
      final CollectionReference tourModelCollection =
          FirebaseFirestore.instance.collection('tourModel');

      for (int i = 0; i < checkBoxStates.length; i++) {
        EmployeeModel selectedEmployee = listAllEmployee.value![i];
        final DocumentReference tourDocRef = tourModelCollection.doc(idTour);
        final CollectionReference tourGuideCollection =
            tourDocRef.collection('tourguide');

        QuerySnapshot querySnapshot = await tourGuideCollection
            .where('employeeId', isEqualTo: selectedEmployee.id)
            .get();

        if (checkBoxStates[i]) {
          if (querySnapshot.docs.isEmpty) {
            await tourGuideCollection.add({
              'employeeId': selectedEmployee.id,
            });
          }
        } else {
          if (querySnapshot.docs.isNotEmpty) {
            for (QueryDocumentSnapshot document in querySnapshot.docs) {
              await document.reference.delete();
            }
          }
        }
      }
      Get.snackbar("Success", "Add employee successfully");
      for (int i = 0; i < checkBoxStates.length; i++) {
        checkBoxStates[i] = false;
      }
      getAllEmployee();
    } catch (e) {
      Get.snackbar("Error", "Error updating tourguide collection: $e");
    }
  }

  Future<void> searchEmployee(String keyword) async {
    listAllEmployee.value = listAllEmployeeData.value
        ?.where((employee) => _containsAllKeywords(employee.email, keyword))
        .toList();
    checkBoxStates =
        List.generate(listAllEmployee.value?.length ?? 0, (index) => false).obs;
  }

  void toggleCheckBox(int index) {
    checkBoxStates[index] = !checkBoxStates[index];
  }

  void setInit() {
    listAllEmployee.value = listAllEmployeeData.value;
    searchEmployeeController.text = "";
  }
}
