import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:app/singleton/AppStorage.dart';
import 'package:app/singleton/dio.dart';

class LanguageController extends GetxController {
  Locale _appLocale = Locale('ar');

  Locale get appLocal => _appLocale;

  fetchLocale() async {
    if (AppStorage().getLanguageCode() == null) {
      AppStorage().setLanguageCode('ar');
      _appLocale = Locale('ar');
      return Null;
    }
    _appLocale = Locale(AppStorage().getLanguageCode() ?? "ar");
    update();
    return _appLocale;
  }

  void changeLanguage(Locale type, Function onDone) async {
    _appLocale = type;
    if (type.languageCode.toLowerCase() == "ar") {
      _appLocale = Locale("ar");
      Get.updateLocale(Locale("ar"));
      AppStorage().setLanguageCode('ar');
      AppStorage().setCountryCode('SA');
    } else {
      _appLocale = Locale("en");
      Get.updateLocale(Locale("en"));
      AppStorage().setLanguageCode('en');
      AppStorage().setCountryCode('US');
    }
    onDone();
    update();
  }
}
