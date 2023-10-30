import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doan_clean_achitec/models/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final _db = FirebaseFirestore.instance;

  RxString userName = ''.obs;
  RxString userEmail = ''.obs;
  String userUID = '';

  final user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    initializeUser();
  }

  void initializeUser() {
    user.value = FirebaseAuth.instance.currentUser;
    final email = user.value?.email;
    userUID = user.value?.uid ?? '';
    if (email != null && email.isNotEmpty) {
      userName.value = email.substring(0, 5);
      userEmail.value = email;
    }
  }

  Future<List<UserModel>> getAllUserModel() async {
    final snapShot = await _db.collection('userModel').get();
    final listUserData =
        snapShot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return listUserData;
  }

  void clearUserName() {
    userName.value = '';
    userEmail.value = '';
    user.value = null;
  }
}
