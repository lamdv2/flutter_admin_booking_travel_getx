import 'package:doan_clean_achitec/shared/constants/local_storage.dart';
import 'package:doan_clean_achitec/shared/constants/string_constants.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();

    await Future.delayed(const Duration(seconds: 1));
    await LocalStorageHelper.initLocalStorageHelper();

    final checkIntroScreen =
        LocalStorageHelper.getValue(StringConst.checkIntro) as bool?;

    try {
      if (checkIntroScreen != null && checkIntroScreen) {
        Get.offNamed(Routes.AUTH);
      } else {
        LocalStorageHelper.setValue(StringConst.checkIntro, true);
        Get.offNamed(Routes.INTRO);
      }
    } catch (e) {
      Get.offNamed(Routes.INTRO);
    }
  }
}
