import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/city/city_model.dart';
import 'package:doan_clean_achitec/models/employee/employee.dart';
import 'package:doan_clean_achitec/models/history/history_model.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/admin/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../profile/image_full_screen.dart';

class UserInTourController extends GetxController {
  final _db = FirebaseFirestore.instance;
  final AdminController adminController = Get.put(AdminController());

  List<String> detailsHotelList = ["Overview", "Itinerary", "Review & Rating"];

  RxBool isCheckSearch = false.obs;
  RxString idTour = ''.obs;
  final cityModel = Rxn<CityModel>();
  final userModel = Rxn<List<UserModel>>();
  final filterListUSerData = Rxn<List<UserModel>>();
  final cityList = Rxn<List<Map<String, String>>>();
  TextEditingController searchController = TextEditingController();
  final items = Rxn<List<String>>([]);
  final getListTourImages = Rxn<List<String>>([]);
  final listAllEmployee = Rxn<List<EmployeeModel>>([]);
  final listAllEmployeeData = Rxn<List<EmployeeModel>>([]);
  TextEditingController searchEmployeeController = TextEditingController();
  RxList<bool> checkBoxStates = ([false]).obs;
  RxList<bool> isCheckListUserParti = ([false]).obs;

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
  Future<UserModel> getUserDetailsById(String id) async {
    final snapShot = await _db.collection('userModel').doc(id).get();

    if (snapShot.exists) {
      return UserModel.fromSnapshot(snapShot);
    } else {
      throw Exception("Error: not exists!!!");
    }
  }

  // Refresh Tour List
  Future<void> refreshTourList() async {
    getAllUserData();
    getAllCity();
  }

  // Get All User Belong to Tour
  Future<void> getUserBooking(String idTour) async {
    final snapShot = await _db
        .collection('historyModel')
        .where("idTour", isEqualTo: idTour)
        .get();
    final listHistoryData =
        snapShot.docs.map((doc) => HistoryModel.fromJson(doc)).toList();

    List<UserModel> listUserModel = [];
    List<bool> listUserParti = [];

    for (var element in listHistoryData) {
      listUserParti.add(element.isCheckUserParti ?? false);
    }

    if (listUserParti.isNotEmpty) {
      isCheckListUserParti.value = listUserParti;
    }

    for (var element in listHistoryData) {
      final snapShot = await _db
          .collection('userModel')
          .where("id", isEqualTo: element.idUser)
          .get();
      final userModel =
          snapShot.docs.map((doc) => UserModel.fromSnapshot(doc)).single;
      listUserModel.add(userModel);
    }

    if (listUserModel.isNotEmpty &&
        listUserModel.length == isCheckListUserParti.length) {
      userModel.value = listUserModel;
      filterListUSerData.value = listUserModel;
    }
  }

  // Get All User
  Future<void> getAllUserData() async {
    final snapShot = await _db.collection('userModel').get();
    final listUserData =
        snapShot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();

    userModel.value = listUserData;
    filterListUSerData.value = listUserData;
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

  // Filter get all
  void getAllTour() {
    userModel.value = filterListUSerData.value;
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
      userModel.value = filterListUSerData.value;
    } else {
      userModel.value = filterListUSerData.value
          ?.where(
            (listTour) => _containsAllKeywords(
              listTour.firstName ?? "",
              keyword,
            ),
          )
          .toList();
    }
  }

  bool _containsAllKeywords(String tourName, String keyword) {
    List<String> searchTerms = keyword.toLowerCase().split(' ');

    return searchTerms.every((term) => tourName.toLowerCase().contains(term));
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
