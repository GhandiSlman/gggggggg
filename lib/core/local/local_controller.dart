import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_consts.dart';

class LocaleController extends GetxController {
  Rx<Locale> initialLang = (box.read('langCode') == 'ar' ? const Locale('ar') : const Locale('en')).obs;

  void changeLocale(String langCode) {
    Locale locale = Locale(langCode);
    box.write('langCode', langCode);
    initialLang.value = locale;
    Get.updateLocale(locale);
  }

  String get currentLanguage => initialLang.value.languageCode == 'ar' ? 'Arabic' : 'English';
}
