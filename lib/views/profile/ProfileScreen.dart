import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/custom_widgets/CustomAppBar.dart';
import 'package:app/custom_widgets/CustomImage.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/custom_widgets/LoadingApp.dart';
import 'package:app/custom_widgets/MainBottomButtons.dart';
import 'package:app/views/auth/ChangePasswordScreen.dart';
import 'package:app/views/auth/LoginScreen.dart';
import 'package:app/views/history/HistoryScreen.dart';
import 'package:app/views/profile/MyInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../extensions/ChromeSettingsForSpecificScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                    selectedIndex: 2,
                  ),
                  appBar: CustomAppBar(
                    title: "personalProfile",
                    titleColor: white,
                    isBack: false,
                    backColor: secondaryColor,
                  ),
                  body: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return false;
                    },
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: 16.w,
                              end: 16.w,
                              bottom: 0.h,
                              top: 24.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    10.r,
                                  ),
                                  child: Center(
                                    child: CustomImage(
                                      image: ASSETS_IMAGES + "profile1.png",
                                      imageHeight: 100.w,
                                      imageWidth: 100.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                CustomText(
                                  "محمد الهاجري",
                                  translate: false,
                                  fontSize: 16,
                                  fontFamily: PRIMARY_FONT_SEMI_BOLD,
                                  textColor: white,
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                CustomText(
                                  "موظف أمن",
                                  translate: false,
                                  fontSize: 14,
                                  fontFamily: PRIMARY_FONT_REGULAR,
                                  textColor: darkSilver,
                                ),
                                SizedBox(
                                  height: 32.h,
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.to(()=> MyInfoScreen());
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Container(
                                    padding: EdgeInsetsDirectional.only(
                                      start: 16.w,
                                      end: 16.w,
                                      bottom: 18.h,
                                      top: 18.h,
                                    ),
                                    margin: EdgeInsetsDirectional.only(
                                      bottom: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: blackLight,
                                      borderRadius: BorderRadius.circular(
                                        10.r,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            CustomImage(
                                              image: ASSETS_ICONS + "user1.svg",
                                              imageHeight: 24.w,
                                              imageWidth: 24.w,
                                            ),
                                            SizedBox(
                                              width: 16.w,
                                            ),
                                            CustomText(
                                              "myInfo",
                                              fontSize: 14,
                                              fontFamily: PRIMARY_FONT_REGULAR,
                                              textColor: white,
                                            ),
                                          ],
                                        ),
                                        CustomImage(
                                          image: ASSETS_ICONS + "go_arrow.svg",
                                          imageHeight: 24.w,
                                          imageWidth: 24.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.to(()=> ChangePasswordScreen());
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Container(
                                    padding: EdgeInsetsDirectional.only(
                                      start: 16.w,
                                      end: 16.w,
                                      bottom: 18.h,
                                      top: 18.h,
                                    ),
                                    margin: EdgeInsetsDirectional.only(
                                      bottom: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: blackLight,
                                      borderRadius: BorderRadius.circular(
                                        10.r,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            CustomImage(
                                              image: ASSETS_ICONS + "lock.svg",
                                              imageHeight: 24.w,
                                              imageWidth: 24.w,
                                            ),
                                            SizedBox(
                                              width: 16.w,
                                            ),
                                            CustomText(
                                              "changePassword",
                                              fontSize: 14,
                                              fontFamily: PRIMARY_FONT_REGULAR,
                                              textColor: white,
                                            ),
                                          ],
                                        ),
                                        CustomImage(
                                          image: ASSETS_ICONS + "go_arrow.svg",
                                          imageHeight: 24.w,
                                          imageWidth: 24.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.to(()=> HistoryScreen());
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Container(
                                    padding: EdgeInsetsDirectional.only(
                                      start: 16.w,
                                      end: 16.w,
                                      bottom: 18.h,
                                      top: 18.h,
                                    ),
                                    margin: EdgeInsetsDirectional.only(
                                      bottom: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: blackLight,
                                      borderRadius: BorderRadius.circular(
                                        10.r,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            CustomImage(
                                              image: ASSETS_ICONS + "clipboard.svg",
                                              imageHeight: 24.w,
                                              imageWidth: 24.w,
                                            ),
                                            SizedBox(
                                              width: 16.w,
                                            ),
                                            CustomText(
                                              "activitiesHistory",
                                              fontSize: 14,
                                              fontFamily: PRIMARY_FONT_REGULAR,
                                              textColor: white,
                                            ),
                                          ],
                                        ),
                                        CustomImage(
                                          image: ASSETS_ICONS + "go_arrow.svg",
                                          imageHeight: 24.w,
                                          imageWidth: 24.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    Get.offAll(()=> LoginScreen());
                                  },
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Container(
                                    padding: EdgeInsetsDirectional.only(
                                      start: 16.w,
                                      end: 16.w,
                                      bottom: 18.h,
                                      top: 18.h,
                                    ),
                                    margin: EdgeInsetsDirectional.only(
                                      bottom: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(
                                       10.r,
                                      ),
                                      border: Border.all(
                                        color: redErrorColor,
                                        width: 0.5.w,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            CustomImage(
                                              image: ASSETS_ICONS + "logout.svg",
                                              imageHeight: 24.w,
                                              imageWidth: 24.w,
                                            ),
                                            SizedBox(
                                              width: 16.w,
                                            ),
                                            CustomText(
                                              "logout",
                                              fontSize: 14,
                                              fontFamily: PRIMARY_FONT_REGULAR,
                                              textColor: redErrorColor,
                                            ),
                                          ],
                                        ),
                                        CustomImage(
                                          image: ASSETS_ICONS + "go_arrow.svg",
                                          imageHeight: 24.w,
                                          imageWidth: 24.w,
                                          color: redErrorColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
          );
        }
    );
  }
}
