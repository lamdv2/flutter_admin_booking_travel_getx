import 'dart:collection';

import 'package:doan_clean_achitec/modules/lang/value/en_US.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'value/ko_KR.dart';
import 'value/vi_VN.dart';

class TranslationService extends Translations {
  static Locale? get locale => fallbackLocale;
  static const fallbackLocale = Locale('en', 'US');

  static final langCodes = ['en', 'vi', 'ko'];

  static final locales = [
    const Locale('en', 'US'),
    const Locale('vi', 'VN'),
    const Locale('ko', 'KR'),
  ];

  static final langs =
      LinkedHashMap.from({'en': 'English', 'vi': 'Tiếng Việt', 'ko': 'Korea'});

  static void changeLocale(String langCode) {
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'ko_KR': ko,
        'vi_VN': vi,
      };

  static Locale _getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ?? Get.deviceLocale?.languageCode;
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }
    return Get.locale!;
  }
}
