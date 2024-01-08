import 'package:app/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class APIsData{
  final Dio client;

  var baseURL = HOST_URL;

  APIsData({required this.client});


}