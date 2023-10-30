import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  RxBool isDarkModeOn = false.obs;

  Future<void> loadDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkModeOn.value = prefs.getBool('dark_mode_key') ?? false;
    update();
  }

  Future<void> toggleDarkMode() async {
    isDarkModeOn.toggle();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode_key', isDarkModeOn.value);
    update();
  }

  void changeMode() {
    toggleDarkMode();
  }
}
