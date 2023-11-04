import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/routes/app_pages.dart';
import 'package:doan_clean_achitec/shared/constants/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modules/lang/translation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  AppController darkMode = AppController();

  await darkMode.loadDarkMode();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppController controller = Get.put(AppController());
  final mainTheme = ThemeData(
    scaffoldBackgroundColor: ColorConstants.bgrLight,
    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
    ),
  );

  final darkTheme = ThemeData.dark();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        enableLog: true,
        initialRoute: Routes.HOME,
        defaultTransition: Transition.fade,
        getPages: AppPages.routes,
        smartManagement: SmartManagement.keepFactory,
        title: 'Flutter GetX Clean Travel',
        theme: controller.isDarkModeOn.value
            ? darkTheme.copyWith(brightness: Brightness.dark)
            : mainTheme.copyWith(brightness: Brightness.light),
        locale: TranslationService.locale,
        fallbackLocale: TranslationService.fallbackLocale,
        translations: TranslationService(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 10.0
    ..backgroundColor = ColorConstants.lightGray
    ..indicatorColor = hexToColor('#64DEE0')
    ..textColor = hexToColor('#64DEE0')
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
