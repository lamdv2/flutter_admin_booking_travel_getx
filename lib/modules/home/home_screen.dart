import 'package:doan_clean_achitec/dark_mode.dart';
import 'package:doan_clean_achitec/models/Destination.dart';
import 'package:doan_clean_achitec/modules/booking/booking.dart';
import 'package:doan_clean_achitec/modules/favorite/favorite.dart';
import 'package:doan_clean_achitec/modules/home/home.dart';
import 'package:doan_clean_achitec/modules/tour/tour.dart';
import 'package:doan_clean_achitec/shared/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../shared/utils/size_utils.dart';
import '../../shared/widgets/stateless/drawer_widget.dart';
import '../auth/user_controller.dart';
import '../discover/discover_screen.dart';
import '../lang/language.dart';
import '../lang/translation_service.dart';
import '../setting/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final user = FirebaseAuth.instance.currentUser!;
final userName = user.email.toString().substring(0, 3);
final UserController userController = Get.find();
final HomeController homeController = Get.find();
final TourController tourController = Get.put(TourController());
final AppController appController = Get.find();

class _HomeScreenState extends State<HomeScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    initializeUser();
    _loadDestination();
    getAllCityInit();
  }

  void getAllCityInit() async {
    await tourController.getAllCity();
    tourController.loadCity();
  }

  void initializeUser() {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user!.email!.isNotEmpty) {
        StringConst.userName = user!.email!.toString().substring(0, 3);
        userController.userName.value = user!.email!.toString().substring(0, 5);
        userController.userEmail.value = user!.email!;
      }
    }
  }

  void _loadDestination() {
    setState(() {
      addListDestination(destiList);
    });
  }

  final _selectedLanguage = Language(1, "🇺🇸", "English", "en").obs;
  Language get selectedLanguage => _selectedLanguage.value;

  void handleLanguageSelection(Language? language) {
    if (language != null) {
      _selectedLanguage.value = language;
      String code = language.code;

      if (code == 'vi') {
        TranslationService.changeLocale('vi');
      } else if (code == 'en') {
        TranslationService.changeLocale('en');
      } else if (code == 'ko') {
        TranslationService.changeLocale('ko');
      }
    }
  }

  List<SpeedDialChild> _buildLanguageOptions() {
    return [
      _buildLanguageOption('🇺🇸 English', 'en'),
      _buildLanguageOption('🇰🇷 China', 'ko'),
      _buildLanguageOption('🇻🇳 Vietnamese', 'vi'),
    ];
  }

  SpeedDialChild _buildLanguageOption(String label, String locale) {
    return SpeedDialChild(
      backgroundColor: ColorConstants.blue,
      label: label,
      onTap: () {
        TranslationService.changeLocale(locale);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: homeController.scaffoldHomeKey,
        drawer: DrawerWidget(),
        body: SafeArea(
          child: Stack(
            children: [
              IndexedStack(
                index: homeController.currentIndex.value,
                children: _widgetOptions(),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.all(12),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: getSize(45),
                    height: getSize(45),
                    child: Card(
                      color: ColorConstants.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      elevation: 3.0,
                      child: SpeedDial(
                        icon: Icons.language,
                        direction: SpeedDialDirection.up,
                        curve: Curves.bounceOut,
                        animatedIconTheme: const IconThemeData(size: 12.0),
                        backgroundColor: ColorConstants.blue,
                        foregroundColor: ColorConstants.white,
                        children: _buildLanguageOptions(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: ColorConstants.white,
        bottomNavigationBar: SalomonBottomBar(
          onTap: (index) {
            homeController.currentIndex.value = index;
          },
          currentIndex: homeController.currentIndex.value,
          selectedItemColor: appController.isDarkModeOn.value
              ? ColorConstants.white
              : ColorConstants.primaryButton,
          unselectedItemColor: appController.isDarkModeOn.value
              ? ColorConstants.white.withOpacity(.5)
              : ColorConstants.primaryButton.withOpacity(0.2),
          backgroundColor: appController.isDarkModeOn.value
              ? ColorConstants.darkAppBar
              : ColorConstants.white,
          curve: Curves.easeOutQuint,
          duration: const Duration(milliseconds: 1000),
          items: [
            SalomonBottomBarItem(
                icon: const Icon(
                  FontAwesomeIcons.house,
                  size: kDefaultIconSize,
                ),
                title: const Text('Home')),
            SalomonBottomBarItem(
                icon: const Icon(
                  FontAwesomeIcons.solidHeart,
                  size: kDefaultIconSize,
                ),
                title: const Text('Likes')),
            SalomonBottomBarItem(
                icon: const Icon(
                  FontAwesomeIcons.ccDiscover,
                  size: kDefaultIconSize,
                ),
                title: const Text('Discover')),
            SalomonBottomBarItem(
                icon: const Icon(
                  FontAwesomeIcons.briefcase,
                  size: kDefaultIconSize,
                ),
                title: const Text('Booking')),
            SalomonBottomBarItem(
                icon: const Icon(
                  FontAwesomeIcons.solidUser,
                  size: kDefaultIconSize,
                ),
                title: const Text('Profile')),
          ],
        ),
      ),
    );
  }

  List<Widget> _widgetOptions() {
    return [
      const HomeTab(),
      const FavotiteScreen(),
      const DiscoverScreen(),
      const BookingScreen(),
      const SettingScreen(),
    ];
  }
}
