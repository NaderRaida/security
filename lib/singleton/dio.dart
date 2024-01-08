import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app/singleton/APIsData.dart';
import 'package:app/singleton/AppStorage.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:app/controller/LanguageController.dart';

final getIt = GetIt.instance;
var firebaseMessaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final navigatorKey = GlobalKey<NavigatorState>();

Future<void> init() async {

  getIt.registerLazySingleton<LanguageController>(() => LanguageController());
  getIt.registerLazySingleton<APIsData>(() => APIsData(client: getIt()));

  getIt.registerLazySingleton<FirebaseMessaging>(() => firebaseMessaging);

  Dio client = Dio(
    BaseOptions(
      headers: {
        'Accept-Language': 'ar',
        'Accept': 'application/json',
        'app_platform': Platform.isAndroid? 'android': 'ios',
      },
    ),
  );
  (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
  getIt.registerLazySingleton<Dio>(() => client);
  getIt.registerLazySingleton(() => http.Client());

  refreshToken();

  firebaseMessaging.subscribeToTopic("all_clients");

}

refreshToken({bool fromLogout = false}) async {
  print("refreshToken .... ${AppStorage().getUserToken()}");
  if (AppStorage().getUserToken() != null) {
      print("refreshToken ..>>>.. ${AppStorage().getUserToken()}");
      getIt<Dio>().options.headers = {
        'Authorization': 'Bearer ${AppStorage().getUserToken()}',
        'Accept-Language':
        getIt<LanguageController>().appLocal.languageCode.toLowerCase(),
        'Accept': 'application/json',
        'app_platform': Platform.isAndroid? 'android': 'ios'
      };

      print("getIt<Dio>().options.headers >> ${getIt<Dio>().options.headers}");

  } else {
    asVisitor();
  }
}

void asVisitor(){
  getIt<Dio>().options.headers = {
    'Accept-Language': getIt<LanguageController>().appLocal.languageCode
        .toLowerCase(),
    'Accept': 'application/json',
    'app_platform': Platform.isAndroid? 'android': 'ios'
  };

  print("user = null >> " + getIt<Dio>().options.headers.toString());
}


