
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/constants/colors.dart';

class ChromeSettingsForSpecificScreen {
  static mainChromeSetting() {
    return SystemUiOverlayStyle.light.copyWith(
      statusBarColor: secondaryColor,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: secondaryColor,
    );
  }

  static chattingChromeSetting() {
    return SystemUiOverlayStyle.light.copyWith(
      statusBarColor: secondaryColor,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: blackLight1,
    );
  }


  static bottomSheetSettings(){
    return SystemUiOverlayStyle.light.copyWith(
      statusBarColor: secondaryColor.withOpacity(0.4),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: blackLight,
    );
  }

  static transparentChromeSetting() {
    return SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: black,
    );
  }

  static primaryWhiteChromeSetting() {
    return SystemUiOverlayStyle.light.copyWith(
      statusBarColor: primaryColor,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: white,
    );
  }

  static whiteChromeSetting() {
    return SystemUiOverlayStyle.light.copyWith(
      statusBarColor: white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: white,
    );
  }

  static alertDialogChromeSetting() {
    return SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
    );
  }

}
