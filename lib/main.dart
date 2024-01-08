import 'dart:io';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/custom_widgets/LoadingApp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/controller/LanguageController.dart';
import 'package:app/utils/AppLocalization.dart';
import 'package:app/views/home/HomeScreen.dart';
import 'package:app/views/splash/SplashScreen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:app/singleton/dio.dart' as dio;
final navigatorKey = GlobalKey<NavigatorState>();


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();
NotificationAppLaunchDetails? notificationAppLaunchDetails;

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ////
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  ////////////////
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
    if (kDebugMode) {
      print("==========> ${remoteMessage.data["type"]}");
    }
    _firebaseMessagingBackgroundHandler(remoteMessage);
  });
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  ///////////////
  var initializationSettingsAndroid = AndroidInitializationSettings('drawable/ic_notification');

  var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int? id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id!, title: title!, body: body!, payload: payload!));
      });
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveBackgroundNotificationResponse: fcmBackground,
    onDidReceiveNotificationResponse: (notificationResponse){
      print("=>> onDidReceiveNotificationResponse");
      if(notificationResponse.payload != null){
        selectNotificationSubject.add(notificationResponse.payload!);
      }
    },
  );
////////////
  await GetStorage.init();
  notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (Platform.isIOS) {
    _requestIOSPermissions();
  }
  await dio.init();
  dio.getIt<LanguageController>().fetchLocale();
  runApp(GetBuilder<GeneralController>(
    init: GeneralController(),
    builder:(controller){
      return RefreshConfiguration(
        footerTriggerDistance: 15,
        headerTriggerDistance: 80.0,
        dragSpeedRatio: 0.91,
        springDescription:
        SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
        headerBuilder: () => MaterialClassicHeader(
          color: white,
          backgroundColor: primaryColor,
        ),
        footerBuilder: () => CustomFooter(
          builder: customFooter,
        ),
        enableLoadingWhenNoData: true,
        enableScrollWhenRefreshCompleted: true,
        enableLoadingWhenFailed: true,
        shouldFooterFollowWhenNotFull: (state) {
          return false;
        },
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          // orientation: Orientation.portrait,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (child, widget){
            return GetMaterialApp(
                title: 'Intelligent Security',
                navigatorKey: navigatorKey,
                locale: Locale('ar'),
                theme: ThemeData(fontFamily: PRIMARY_FONT_LIGHT),
                debugShowCheckedModeBanner: false,
                localizationsDelegates: [
                  AppLocalization.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate
                ],
                supportedLocales: [
                  Locale('en'),
                  Locale('ar'),
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale!.languageCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                builder: (BuildContext context,Widget? child){
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: 1.1,
                    ),
                    child: child!,
                  );
                },
                home: SplashScreen());
          },
        ),
      );
    } ,
  ));
  _configureSelectNotificationSubject();
  _configureDidReceiveLocalNotificationSubject();
}

Widget customFooter(BuildContext context, LoadStatus? mode) {
  Widget body;
  if (mode == LoadStatus.idle) {
    body = CustomText(
      "empty",
      fontFamily: PRIMARY_FONT_BOLD,
      fontSize: 13,
    );
  } else if (mode == LoadStatus.loading) {
    body = LoadingApp(
      width: 1.0,
      height: 50.0,
      color: primaryColor,
    );
  } else if (mode == LoadStatus.failed) {
    body = CustomText(
      "LoadFailedClickRetry",
      fontFamily: PRIMARY_FONT_BOLD,
      fontSize: 13,
    );
  } else if (mode == LoadStatus.canLoading) {
    body = CustomText(
      "releaseToLoadMore",
      fontFamily: PRIMARY_FONT_BOLD,
      fontSize: 13,
    );
  } else {
    body = CustomText(
      "noMoreData",
      fontFamily: PRIMARY_FONT_BOLD,
      fontSize: 13,
    );
  }
  return Container(
    height: 55.0.h,
    child: Center(child: body),
  );
}

void _requestIOSPermissions() {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );
}

fcmBackground(NotificationResponse response){
  print("=>> {{fcmBackground}} local notification package");
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  print("===========>>>>> Handling a background message & Terminated Message "
      ": ID : ${message.data["id"]} || TITLE : ${message.notification!.title} "
      "||| ==>> ${message.data.toString()}");
  if(navigatorKey.currentContext != null){
    Get.offAll(()=>HomeScreen());
  }
}
void _configureSelectNotificationSubject() {
  selectNotificationSubject.stream.listen((String type) async {
    print("selectNotificationSubject.stream.listen = $type");
    String fromNotification = type.split("\$")[0];

    if(fromNotification == "true"){
      print("fromNotification = true >>$fromNotification");
      Get.offAll(()=>HomeScreen());
    }
  });
}

void _configureDidReceiveLocalNotificationSubject() {
  didReceiveLocalNotificationSubject.stream
      .listen((ReceivedNotification receivedNotification) async {
    await showDialog(
      context: navigatorKey.currentContext!,
      barrierColor: barrierColor,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: receivedNotification.title != null
            ? Text(receivedNotification.title)
            : null,
        content: receivedNotification.body != null
            ? Text(receivedNotification.body)
            : null,
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Get.back();
              String fromNotification = receivedNotification.payload.split("\$")[0];
              String orderId = receivedNotification.payload.split("\$")[1];
              String type = receivedNotification.payload.split("\$")[2];
              String id = receivedNotification.payload.split("\$")[3];
              String notificationId = receivedNotification.payload.split("-")[4];
              if(fromNotification == "true"){
                print("fromNotification = true >>"+fromNotification.toString());
                Get.offAll(()=>HomeScreen());
              }
            },
          )
        ],
      ),
    );
  });
}


