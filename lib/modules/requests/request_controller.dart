import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';

import '../../models/history/history_model.dart';
import '../../models/tour/tour_model.dart';
import '../home/home_controller.dart';

class RequestController extends GetxController {
  final _db = FirebaseFirestore.instance;

  HomeController homeController = Get.find();

  final getAllListHistory = Rxn<List<TourModel>>([]);
  final getListHisWaiting = Rxn<List<TourModel>>([]);

  final getAllListHistoryToDate = Rxn<List<HistoryModel>>([]);
  final getListHisWaitingToDate = Rxn<List<HistoryModel>>([]);

  final getAllListUser = Rxn<List<UserModel>>([]);
  final getAllListUserWaiting = Rxn<List<UserModel>>([]);
  final getAllListImageTour = Rxn<List<String>>([]);

  RxString urlImage = ''.obs;

  Rx<bool> isShowLoading = true.obs;
  SMITrigger? check;
  SMITrigger? error;
  SMITrigger? reset;

  StateMachineController getRiveController(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);
    return controller;
  }

  @override
  void onInit() {
    super.onInit();
    getAllTourModelData();
    loadIndicatorRive();
  }

  // Get image tour

  void getUrlImage(String nameImage) async {
    urlImage.value = await getImageStorage(nameImage);
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

  // Get All Tour

  Future<void> getAllTourModelData() async {
    getListHisWaiting.value?.clear();

    getListHisWaiting.value = await getTourHistoryWaiting();
  }

  Future<List<TourModel>?> getTourHistoryWaiting() async {
    final snapShot = await _db
        .collection('historyModel')
        .where('status', isEqualTo: "waiting")
        .get();

    final listTourHistoryData =
        snapShot.docs.map((doc) => HistoryModel.fromJson(doc)).toList();

    List<TourModel> listTourModel = [];

    if (listTourHistoryData.isNotEmpty) {
      getAllListUserWaiting.value = [];

      for (int i = 0; i < listTourHistoryData.length; i++) {
        final snapShotUser = await _db
            .collection('userModel')
            .doc(listTourHistoryData[i].idUser)
            .get();

        if (snapShotUser.exists) {
          getAllListUserWaiting.value
              ?.add(UserModel.fromSnapshot(snapShotUser));
        }
      }
    }

    if (listTourHistoryData.isNotEmpty) {
      getListHisWaitingToDate.value?.clear();
      getListHisWaitingToDate.value = listTourHistoryData;
      getAllListImageTour.value = [];

      for (int i = 0; i < listTourHistoryData.length; i++) {
        final snapShotTour = await _db
            .collection('tourModel')
            .doc(listTourHistoryData[i].idTour)
            .get();

        if (snapShotTour.exists) {
          listTourModel.add(TourModel.fromJson(snapShotTour));
          String imageTour = await getImageStorage(
              TourModel.fromJson(snapShotTour).images?.isNotEmpty == true
                  ? TourModel.fromJson(snapShotTour).images!.first
                  : '/assets/images/city_7.jpg');

          getAllListImageTour.value?.add(imageTour);
        }
      }
    }

    return listTourModel;
  }

  showAlertDialog(BuildContext context, String idTour) {
    Widget cancelButton = TextButton(
      child: Text(
        StringConst.cancel.tr,
        style: const TextStyle(
          color: ColorConstants.titleSearch,
        ),
      ),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text(StringConst.ok.tr),
      onPressed: () {
        approveTour(idTour);
        Get.back();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(StringConst.approve.tr),
      content: const Text("Would you like to approve this tour?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> approveTour(String idTour) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _db.collection('historyModel').doc(idTour).get();

      if (snapshot.exists) {
        HistoryModel historyModel = HistoryModel.fromJson(snapshot);

        historyModel.status = 'done';

        await _db
            .collection('historyModel')
            .doc(idTour)
            .update(historyModel.toJson());
        getAllTourModelData();
      } else {
        Get.snackbar("Error", "Something went wrong!!!");
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> refreshHistory() async {
    getAllTourModelData();
  }

  String timestampToString(Timestamp timestamp) {
    try {
      DateTime dateTime = timestamp.toDate();

      String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

      return formattedDate;
    } catch (e) {
      return 'Lỗi: $e';
    }
  }

  void indicatorRive() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (getListHisWaiting.value != null &&
            getListHisWaiting.value!.isNotEmpty) {
          // check?.fire();
          Future.delayed(const Duration(seconds: 1), () {
            isShowLoading.value = false;
          });
        } else {
          Future.delayed(const Duration(seconds: 1), () {
            // error?.fire();
            isShowLoading.value = false;
          });
        }
      },
    );
  }

  void loadIndicatorRive() {
    isShowLoading.value = true;
    indicatorRive();
  }
}
