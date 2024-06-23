import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/core/utils/app_consts.dart';

class LocaleController extends GetxController {
  Locale initialLang = box.read('langCode') == 'ar' ? const Locale('ar') : const Locale('en');

  void changeLocal(String langCode) {
    Locale locale = Locale(langCode);
    box.write('langCode', langCode);
    Get.updateLocale(locale);
  }
}
