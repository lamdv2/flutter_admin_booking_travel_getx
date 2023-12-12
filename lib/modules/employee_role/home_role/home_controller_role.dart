import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/employee/employee.dart';
import 'package:doan_clean_achitec/shared/constants/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/history/history_model.dart';

class HomeRoleController extends GetxController {
  RxInt currentIndex = 0.obs;
  final _db = FirebaseFirestore.instance;
  final employeeModel = Rxn<EmployeeModel>();

  final getAllListHistory = Rxn<List<HistoryModel>>();
  final getListHistoryByUserId = Rxn<List<HistoryModel>>();
  final scaffoldHomeKey = GlobalKey<ScaffoldState>();

  @override
  Future<void> onInit() async {
    String emailEmployee = await getEmail();
    getUserDetails(emailEmployee);
    super.onInit();
  }

  Future<String> getEmail() async {
    return await LocalStorageHelper.getValue("emailEmployee") ?? "";
  }

// Get All Tour
  Future<void> getAllTourModelData() async {
    final snapShot = await _db.collection('historyModel').get();
    final listTourData =
        snapShot.docs.map((doc) => HistoryModel.fromJson(doc)).toList();

    getAllListHistory.value = listTourData;
  }

  Future<void> getUserDetails(String email) async {
    final snapShot =
        await _db.collection('employee').where('email', isEqualTo: email).get();

    if (snapShot.docs.isNotEmpty) {
      employeeModel.value =
          snapShot.docs.map((e) => EmployeeModel.fromJson(e)).single;
    }
  }

  Future<void> getTourDetailsById(String userId) async {
    final snapShot = await _db
        .collection('historyModel')
        .where('idUser', isEqualTo: userId)
        .get();

    final historyData =
        snapShot.docs.map((e) => HistoryModel.fromJson(e)).toList();
    getListHistoryByUserId.value = historyData;
  }

  void openDrawer() {
    scaffoldHomeKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldHomeKey.currentState?.closeDrawer();
  }
}
