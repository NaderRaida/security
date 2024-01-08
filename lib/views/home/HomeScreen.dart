import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/custom_widgets/ButtonApp.dart';
import 'package:app/custom_widgets/CustomImage.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/custom_widgets/LoadingApp.dart';
import 'package:app/custom_widgets/MainBottomButtons.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/singleton/AppStorage.dart';
import 'package:app/views/chat/ChattingScreen.dart';
import 'package:app/views/history/HistoryScreen.dart';
import 'package:app/views/statistics/StatisticsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RefreshController refreshController = RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(
        init: GeneralController(),
        builder: (controller) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: ChromeSettingsForSpecificScreen.mainChromeSetting(),
            child: Container(
              color: secondaryColor,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: secondaryColor,
                  bottomNavigationBar: MainBottomButtons(
                    selectedIndex: -1,
                  ),
                  body: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return false;
                    },
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: false,
                      controller: refreshController,
                      onRefresh: onRefresh,
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: 16.w,
                              end: 16.w,
                              bottom: 0.h,
                              top: 0.h,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 40.h,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                     10.r,
                                    ),
                                    child: Center(
                                      child: CustomImage(
                                        image: ASSETS_IMAGES + "profile.png",
                                        imageHeight: 100.w,
                                        imageWidth: 100.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        "welcome",
                                        fontSize: 14,
                                        fontFamily: PRIMARY_FONT_REGULAR,
                                        textColor: white,
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      CustomText(
                                        "محمد",
                                        translate: false,
                                        fontSize: 14,
                                        fontFamily: PRIMARY_FONT_BOLD,
                                        textColor: primaryColor,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        "lastLogin",
                                        fontSize: 14,
                                        fontFamily: PRIMARY_FONT_REGULAR,
                                        textColor: darkSilver,
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      CustomText(
                                        "اليوم 12:30 م",
                                        translate: false,
                                        fontSize: 14,
                                        fontFamily: PRIMARY_FONT_BOLD,
                                        textColor: white,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        "currentLocation",
                                        fontSize: 14,
                                        fontFamily: PRIMARY_FONT_REGULAR,
                                        textColor: darkSilver,
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      CustomText(
                                        "بوابة 3 الشرقية",
                                        translate: false,
                                        fontSize: 14,
                                        fontFamily: PRIMARY_FONT_BOLD,
                                        textColor: white,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsetsDirectional.only(
                                          start: 9.w,
                                          end: 8.w,
                                          bottom: 9.h,
                                          top: 9.h,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                          border: Border.all(
                                            color: blackLight,
                                            width: 0.5.w,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomImage(
                                              image: ASSETS_ICONS + "flash.svg",
                                              imageWidth: 24.w,
                                              imageHeight: 24.w,
                                            ),
                                            SizedBox(
                                              width: 12.w,
                                            ),
                                            CustomText(
                                              "onlineOnServer",
                                              textColor: white,
                                              fontFamily: PRIMARY_FONT_REGULAR,
                                              fontSize: 14,
                                            ),
                                            SizedBox(
                                              width: 24.w,
                                            ),
                                            Container(
                                              width: 12.w,
                                              height: 12.w,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                 15.r,
                                                ),
                                                color: redErrorColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsetsDirectional.only(
                                          start: 9.w,
                                          end: 8.w,
                                          bottom: 9.h,
                                          top: 9.h,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                          border: Border.all(
                                            color: blackLight,
                                            width: 0.5.w,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomImage(
                                              image: ASSETS_ICONS + "location.svg",
                                              imageWidth: 24.w,
                                              imageHeight: 24.w,
                                            ),
                                            SizedBox(
                                              width: 12.w,
                                            ),
                                            CustomText(
                                              "locationAvailable",
                                              textColor: white,
                                              fontFamily: PRIMARY_FONT_REGULAR,
                                              fontSize: 14,
                                            ),
                                            SizedBox(
                                              width: 24.w,
                                            ),
                                            Container(
                                              width: 12.w,
                                              height: 12.w,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                  15.r,
                                                ),
                                                color: primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: AppStorage().getUserType() == CLIENT_USER ? 15.h : 20.h,
                                  ),
                                  ButtonApp(
                                    text: AppStorage().getUserType() == CLIENT_USER ?
                                    "talkWithGateAdmin" : "talkWithYourAdmin",
                                    icon: CustomImage(
                                      image: ASSETS_ICONS + "chat.svg",
                                      imageHeight: 24.w,
                                      imageWidth: 24.w,
                                    ),
                                    width: 358,
                                    height: 60,
                                    fontSize: 16,
                                    fontFamily: PRIMARY_FONT_REGULAR,
                                    textColor: white,
                                    color: blackLight,
                                    function: (){
                                      Get.to(()=> ChattingScreen(
                                        myData: {},
                                        otherData: {},
                                      ));
                                    },
                                  ),
                                  SizedBox(
                                    height: AppStorage().getUserType() == SUPERVISOR_USER ? 20.h : 110.h,
                                  ),
                                  CustomText(
                                    "fastLinks",
                                    textColor: white,
                                    fontFamily: PRIMARY_FONT_SEMI_BOLD,
                                    fontSize: 14,
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Get.to(()=> HistoryScreen());
                                        },
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsetsDirectional.only(
                                            start: 43.w,
                                            end: 43.w,
                                            bottom: 16.h,
                                            top: 16.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: blackLight,
                                            borderRadius: BorderRadius.circular(
                                             10.r,
                                            ),
                                          ),
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                CustomImage(
                                                  image: ASSETS_ICONS + "history.svg",
                                                  imageWidth: 32.w,
                                                  imageHeight: 32.w,
                                                ),
                                                SizedBox(
                                                  height: 15.h,
                                                ),
                                                CustomText(
                                                  "operationsHistory",
                                                  fontSize: 14,
                                                  fontFamily: PRIMARY_FONT_REGULAR,
                                                  textColor: white,
                                                  paragraph: true,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsetsDirectional.only(
                                          start: 40.w,
                                          end: 40.w,
                                          bottom: 16.h,
                                          top: 16.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: blackLight,
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                        ),
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CustomImage(
                                                image: ASSETS_ICONS + "emargence.svg",
                                                imageWidth: 32.w,
                                                imageHeight: 32.w,
                                              ),
                                              SizedBox(
                                                height: 15.h,
                                              ),
                                              CustomText(
                                                "enableAlert",
                                                fontSize: 14,
                                                fontFamily: PRIMARY_FONT_REGULAR,
                                                textColor: white,
                                                paragraph: true,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if(AppStorage().getUserType() == SUPERVISOR_USER)...[
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    CustomText(
                                      "statistics",
                                      textColor: white,
                                      fontFamily: PRIMARY_FONT_SEMI_BOLD,
                                      fontSize: 14,
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    SizedBox(
                                      height: 110.h,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: 3,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (BuildContext context,int index){
                                          return Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsetsDirectional.only(
                                              end: 8.w,
                                            ),
                                            padding: EdgeInsetsDirectional.only(
                                              start: index == 2 ? 33.w : 12.w,
                                              end: index == 2 ? 33.w : 12.w,
                                              bottom: 14.h,
                                              top: 14.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: blackLight,
                                              borderRadius: BorderRadius.circular(
                                                10.r,
                                              ),
                                            ),
                                            child: Center(
                                              child: index == 2 ?
                                              InkWell(
                                                onTap: (){
                                                  Get.to(()=> StatisticsScreen());
                                                },
                                                splashColor: Colors.transparent,
                                                highlightColor: Colors.transparent,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    CustomText(
                                                      "more",
                                                      fontSize: 12,
                                                      fontFamily: PRIMARY_FONT_REGULAR,
                                                      textColor: lightSilver,
                                                      paragraph: true,
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      width: 16.w,
                                                    ),
                                                    CustomImage(
                                                      image: ASSETS_ICONS + "arrow_left.svg",
                                                      imageWidth: 44.w,
                                                      imageHeight: 44.w,
                                                    ),
                                                  ],
                                                ),
                                              ) :
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  CustomText(
                                                    "120",
                                                    translate: false,
                                                    fontSize: 24,
                                                    fontFamily: PRIMARY_FONT_REGULAR,
                                                    textColor: white,
                                                    paragraph: true,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  SizedBox(
                                                    height: 16.h,
                                                  ),
                                                  CustomText(
                                                    "حارس في الخدمة اليوم",
                                                    translate: false,
                                                    fontSize: 14,
                                                    fontFamily: PRIMARY_FONT_REGULAR,
                                                    textColor: darkSilver,
                                                    paragraph: true,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          if(controller.isLoading)
                            LoadingApp(
                              color: white,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }
}
