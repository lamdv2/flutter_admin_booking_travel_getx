import 'package:doan_clean_achitec/modules/admin/admin_binding.dart';
import 'package:doan_clean_achitec/modules/admin/admin_create_tour_screen.dart';
import 'package:doan_clean_achitec/modules/admin/admin_screen.dart';
import 'package:doan_clean_achitec/modules/admin/admin_update_tour_screen.dart';
import 'package:doan_clean_achitec/modules/detail_place/detail_place.dart';
import 'package:doan_clean_achitec/modules/google_map/google_map.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/modules/hotel/hotel_all_screen.dart';
import 'package:doan_clean_achitec/modules/hotel/hotel_screen.dart';
import 'package:doan_clean_achitec/modules/hotel_detail/hotel_detail_binding.dart';
import 'package:doan_clean_achitec/modules/hotel_detail/hotel_detail_screen.dart';
import 'package:doan_clean_achitec/modules/intro/intro_binding.dart';
import 'package:doan_clean_achitec/modules/intro/intro_screen.dart';
import 'package:doan_clean_achitec/modules/requests/request.dart';
import 'package:doan_clean_achitec/modules/room/room.dart';
import 'package:doan_clean_achitec/modules/scan_screen/scan_qr_code_biding.dart';
import 'package:doan_clean_achitec/modules/scan_screen/scan_qr_code_screen.dart';
import 'package:doan_clean_achitec/modules/setting/setting_screen.dart';
import 'package:doan_clean_achitec/modules/splash/splash_binding.dart';
import 'package:doan_clean_achitec/modules/splash/splash_screen.dart';
import 'package:doan_clean_achitec/modules/tour/tour.dart';
import 'package:doan_clean_achitec/shared/utils/select_date.dart';
import 'package:get/get.dart';

import '../models/history_tour/history_tour_screen.dart';
import '../modules/auth/auth_login_screen.dart';

part 'app_routes.dart';

class AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.INTRO,
      page: () => const IntroScreen(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.DETAIL_PLACE,
      page: () => const DetailPlaceScreen(),
      binding: DetailPlaceBinding(),
    ),
    GetPage(
      name: Routes.HOTEL,
      page: () => const HotelScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_HOTEL,
      page: () => const HotelDetailScreen(),
      binding: HotelDetailBinding(),
    ),
    GetPage(
      name: Routes.SETTING,
      page: () => const SettingScreen(),
    ),
    GetPage(
      name: Routes.ROOM,
      page: () => const RoomScreen(),
      binding: RoomBinding(),
    ),
    GetPage(
      name: Routes.DETAIL_HOTEL,
      page: () => const HotelDetailScreen(),
      binding: HotelDetailBinding(),
    ),
    GetPage(
      name: Routes.HOTEL_ALL,
      page: () => const HotelAllScreen(),
    ),
    GetPage(
      name: Routes.TOUR,
      page: () => const TourScreen(),
      binding: TourBinding(),
    ),
    GetPage(
      name: Routes.TOUR_DETAILS,
      page: () => TourDetailsScreen(),
      binding: TourBinding(),
    ),
    GetPage(
      name: Routes.SELECT_DATE,
      page: () => SelectDateScreen(),
    ),
    GetPage(
      name: Routes.HISTORY_TOUR_SCREEN,
      page: () => const HistoryScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.ADMIN_SCREEN,
      page: () => const AdminScreen(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: Routes.ADMIN_CREATE_SCREEN,
      page: () => const AdminCreateScreen(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: Routes.ADMIN_UPDATE_SCREEN,
      page: () => const AdminUpdateScreen(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: Routes.GOOGLE_MAP_SCREEN,
      page: () => const GoogleMapScreen(),
    ),
    GetPage(
      name: Routes.REQUEST_TOUR,
      page: () => const RequestScreen(),
      binding: RequestBinding(),
    ),
    GetPage(
      name: Routes.QR_CODE,
      page: () => const ScanQRCodeScreen(),
      binding: ScanQrCodeBinding(),
    ),
  ];
}
