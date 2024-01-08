import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/utils/AppLocalization.dart';

String getTranslated(BuildContext context, String key) {
  return AppLocalization.of(Get.context!)!.translate(key).toString();
}