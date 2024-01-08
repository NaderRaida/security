import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:app/singleton/AppStorage.dart';
import 'package:app/views/auth/LoginScreen.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/main.dart' as main;
import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/views/home/HomeScreen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../../extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    checkAppBadger();
    tz.initializeTimeZones();
    initFCM();
    startTime();
  }
  void navigationPage() {
    Get.off(()=> HomeScreen());
  }

  startTime() async {
    AppStorage().setUserType(SUPERVISOR_USER);
    var duration = Duration(seconds: 3);
    return Timer(duration, navigationPage);
  }


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ChromeSettingsForSpecificScreen.mainChromeSetting(),
      child: Container(
        color: secondaryColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: secondaryColor,
            bottomNavigationBar: Container(
              height: 50.h,
              child: Center(
                child: CustomText(
                  "loading",
                  fontSize: 16,
                  fontFamily: PRIMARY_FONT_REGULAR,
                  textColor: whiteLight,
                ),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ASSETS_IMAGES + "app_logo.png",
                    width: 77.w,
                    height: 64.w,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SvgPicture.asset(
                    ASSETS_IMAGES + "splash_hint.svg",
                    width: 202.w,
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void initFCM() {
    FirebaseMessaging.instance.getInitialMessage().then((initialMessage) {
      if(initialMessage != null){
        Get.off(()=>LoginScreen());
      }
    });
    ////////////
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      if (kDebugMode) {
        print(
            " ==========>>> FirebaseMessaging.onMessage ||| BODY : ${notification.body} ||| TITLE : ${notification.title} \n"
                "|| ID : ${message.data["id"]} || TYPE : ${message.data["type"]} "
                "|| "
                "${message.data.toString()} ||| }");
      }
      showNotification(message);
    });
  }


  Future<void> showNotification(RemoteMessage message) async {
    bool fromNotification = message != null;
    String id;
    String type;
    if (kDebugMode) {
      print('message.data >> ${message.data}');
    }
    fromNotification = message.data != null ? true : false;
    type = message.data['type'] ?? "0";
    id = message.data['id'] ?? "-1";
    var vibrationPattern = new Int64List(3);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 2000;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      /*"channel id $type", "channel name $type", "channel description $type",*/
        "channel id 3",
        "channel name 3",
        channelDescription: "notification channel description 3",
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        playSound: true,
        enableVibration: true,
        sound: const RawResourceAndroidNotificationSound(
          /*message["data"]["sound"]*/
            ""),
        channelShowBadge: true,
        icon: "drawable/ic_notification",
        styleInformation: const BigTextStyleInformation(''),
        color: primaryColor,
        vibrationPattern: vibrationPattern);
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
      sound: "",
      presentSound: true,
      badgeNumber: 1,
      presentBadge: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await main.flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        message.notification!.title,
        message.notification!.body,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 3)),
        platformChannelSpecifics,
        payload: "$fromNotification||$id||$type",
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  void checkAppBadger() async {
    if (await FlutterAppBadger.isAppBadgeSupported()) {
      if (kDebugMode) {
        print("removeBadge ==> DONE");
      }
      FlutterAppBadger.removeBadge();
    } else {
      if (kDebugMode) {
        print("removeBadge ==> FALSE");
      }
    }
  }



}
