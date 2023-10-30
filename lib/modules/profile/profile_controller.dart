import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/modules/profile/edit_profile.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:doan_clean_achitec/shared/utils/focus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../auth/user_controller.dart';

class ProfileController extends GetxController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final editEmailController = TextEditingController();
  final editFirstNameController = TextEditingController();
  final editLastNameController = TextEditingController();
  final editPassWordController = TextEditingController();
  final editImageAvatarController = TextEditingController();
  final editPhoneNumberController = TextEditingController();
  final editLocationController = TextEditingController();

  final UserController userController = Get.find();
  final HomeController homeController = Get.put(HomeController());

  final scaffoldProfileKey = GlobalKey<ScaffoldState>();

  RxString imageUpload = ''.obs;
  RxString urlImage = ''.obs;
  RxString urlImageOld = ''.obs;

  Rx<List<AssetEntity>> imageFonts = Rx([]);

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      homeController.getUserDetails(userController.userEmail.value),
    ]);
  }

  void getUrlImage() async {
    urlImage.value = await getImageStorage(
      homeController.userModel.value?.imgAvatar ?? '',
    );
  }

  void getDeleteImage(String nameImage) async {
    if (nameImage.isNotEmpty) {
      try {
        final desertRef = FirebaseStorage.instance.ref().child(nameImage);
        await desertRef.delete();
        urlImageOld.value = '';
      } catch (e) {
        return;
      }
    }
  }

  Future<void> pickImages(BuildContext context) async {
    final resultList = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: 5,
        selectedAssets: imageFonts.value,
        requestType: RequestType.image,
      ),
    );
    if (resultList != null && resultList.isNotEmpty) {
      imageFonts.value = resultList;
    }
  }

  Future<String> uploadImageToStorage(
    String childName,
    Uint8List file,
  ) async {
    var uuid = const Uuid();

    Reference ref = _storage.ref().child(childName).child(uuid.v4());
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;

    return ref.fullPath;
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

  Future<Uint8List> assetEntityToUint8List(AssetEntity assetEntity) async {
    final file = await assetEntity.originFile;
    if (file != null) {
      List<int> bytes = await file.readAsBytes();
      return Uint8List.fromList(bytes);
    }
    throw Exception('Failed to read asset data');
  }

  Future<void> updateUserProfile(UserModel userModel) async {
    await _firestore
        .collection('userModel')
        .doc(userModel.id)
        .update(userModel.toJson())
        .then((value) {
      Get.snackbar("Success!", 'Edit profile successfully',
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.black87);
      Future.wait([
        homeController
            .getUserDetails(homeController.userModel.value?.email ?? '')
      ]);
      getUrlImage();
    }).catchError((onError) {
      Get.snackbar("Error!!!", 'Edit profile error: ${onError.toString()}',
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.black87);
    });
  }

  void createUser(UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection('userModel')
        .add(userModel.toJson())
        .whenComplete(
          () => Get.snackbar(
            "Success",
            "Your account have been created!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: ColorConstants.blue.withOpacity(.1),
            colorText: ColorConstants.blue,
          ),
        )
        // ignore: body_might_complete_normally_catch_error
        .catchError((error) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try again!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorConstants.red.withOpacity(.1),
        colorText: ColorConstants.red,
      );
    });
  }

  Future<bool> isCheckExist(String email) async {
    final snapShot = await FirebaseFirestore.instance
        .collection('userModel')
        .where('email', isEqualTo: email)
        .get();
    if (snapShot.docs.isNotEmpty) {
      return true;
    }

    return false;
  }

  Future<void> confirmLogoutDialog(
      BuildContext context, String title, Function() function) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: const Text("Do you want to logout?"),
          actions: [
            TextButton(
              onPressed: Get.back,
              child: Text(
                StringConst.cancel.tr,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: function,
              child: Text(
                StringConst.ok.tr,
              ),
            ),
          ],
        );
      },
    );
  }

  void openDrawer() {
    scaffoldProfileKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    scaffoldProfileKey.currentState?.closeDrawer();
  }

  void signUserOut(BuildContext context) async {
    AppFocus.unFocus(context);
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleSignIn googleSignIn = GoogleSignIn();

    confirmLogoutDialog(
      context,
      'Logout',
      () async {
        Get.back();

        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            Timer(const Duration(seconds: 1), () {
              Get.back();
            });
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );

        try {
          await auth.signOut();

          await googleSignIn.signOut();

          userController.clearUserName();

          userController.userName.value = '';

          userController.userEmail.value = '';

          profileController.imageFonts.value.clear();

          clearEditController();
        } catch (e) {
          wrongMessage("Logout failed: $e");
        }
      },
    );
  }

  // ignore: non_constant_identifier_names
  void Incorrect(String text) {
    final context = Get.context;
    showDialog(
      context: context!,
      anchorPoint: const Offset(10, 10),
      builder: (context) {
        return Center(
          child: AlertDialog(
            title: Center(child: Text(text)),
          ),
        );
      },
    );
  }

  void getEditProfile() {
    if (homeController.userModel.value != null) {
      editEmailController.text = homeController.userModel.value?.email ?? '';
      editFirstNameController.text =
          homeController.userModel.value?.firstName ?? '';
      editLastNameController.text =
          homeController.userModel.value?.lastName ?? '';
      editPassWordController.text =
          homeController.userModel.value?.passWord ?? '';
      editImageAvatarController.text =
          homeController.userModel.value?.imgAvatar ?? '';
      editPhoneNumberController.text =
          homeController.userModel.value?.phoneNub ?? '';
      editLocationController.text =
          homeController.userModel.value?.location ?? '';
    }
  }

  void clearEditController() {
    editEmailController.clear();
    editFirstNameController.clear();
    editLastNameController.clear();
    editPassWordController.clear();
    editImageAvatarController.clear();
    editPhoneNumberController.clear();
    editLocationController.clear();
  }

  Future<void> wrongMessage(String message) async {
    await Future.delayed(const Duration(seconds: 2));

    await Future.microtask(
      () {
        final context = Get.context;
        showDialog(
          context: context!,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.blue,
              title: Text(
                message,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            );
          },
        );
      },
    );
  }
}
