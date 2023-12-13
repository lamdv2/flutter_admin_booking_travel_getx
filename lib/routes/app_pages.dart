import 'package:doan_clean_achitec/modules/admin/admin_binding.dart';
import 'package:doan_clean_achitec/modules/admin/admin_create_tour_screen.dart';
import 'package:doan_clean_achitec/modules/admin/admin_screen.dart';
import 'package:doan_clean_achitec/modules/admin/admin_update_tour_screen.dart';
import 'package:doan_clean_achitec/modules/chart/chart.dart';
import 'package:doan_clean_achitec/modules/detail_place/detail_place.dart';
import 'package:doan_clean_achitec/modules/employee_role/employee_role.dart';
import 'package:doan_clean_achitec/modules/employee_role/home_role/home_binding_role.dart';
import 'package:doan_clean_achitec/modules/employee_role/home_role/home_screen_role.dart';
import 'package:doan_clean_achitec/modules/employee_role/tour_details/tour_role_binding.dart';
import 'package:doan_clean_achitec/modules/employee_role/user_in_tour/user_in_tour.dart';
import 'package:doan_clean_achitec/modules/google_map/google_map.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/modules/hotel/hotel_all_screen.dart';
import 'package:doan_clean_achitec/modules/hotel/hotel_screen.dart';
import 'package:doan_clean_achitec/modules/hotel_detail/hotel_detail_binding.dart';
import 'package:doan_clean_achitec/modules/hotel_detail/hotel_detail_screen.dart';
import 'package:doan_clean_achitec/modules/intro/intro_binding.dart';
import 'package:doan_clean_achitec/modules/intro/intro_screen.dart';
import 'package:doan_clean_achitec/modules/profile/edit_profile.dart';
import 'package:doan_clean_achitec/modules/profile/profile_binding.dart';
import 'package:doan_clean_achitec/modules/requests/request.dart';
import 'package:doan_clean_achitec/modules/requests/tour_request_details.dart';
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
import '../modules/employee_role/tour_details/tour_role_details_screen.dart';

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
      page: () => ScanQRCodeScreen(),
      binding: ScanQrCodeBinding(),
    ),
    GetPage(
      name: Routes.TOUR_REQUEST_DETAILS,
      page: () => TourRequestDetails(),
      binding: RequestBinding(),
    ),
    GetPage(
      name: Routes.CHART_SCREEN,
      page: () => const ChartScreen(),
      binding: ChartBinding(),
    ),
    GetPage(
      name: Routes.HOME_SCREEN_ROLE,
      page: () => const HomeScreenRole(),
      binding: HomeRoleBinding(),
    ),
    GetPage(
      name: Routes.EMPLOYEE_SCREEN_ROLE,
      page: () => EmployeeRoleScreen(),
      binding: EmployeeRoleBinding(),
    ),
    GetPage(
      name: Routes.EDIT_PROFILE,
      page: () => const EditProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.TOUR_ROLE_DETAIL_SCREEN,
      page: () => TourRoleDetailsScreen(),
      binding: TourRoleBinding(),
    ),
    GetPage(
      name: Routes.USER_IN_TOUR,
      page: () => UserInTourScreen(),
      binding: UserInTourBinding(),
    ),
  ];
}
