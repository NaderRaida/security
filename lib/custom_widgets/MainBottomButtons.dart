import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/custom_widgets/CustomImage.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/custom_widgets/OptionsScanMenu.dart';
import 'package:app/views/chat/MessagesScreen.dart';
import 'package:app/views/home/HomeScreen.dart';
import 'package:app/views/notifications/NotificationsScreen.dart';
import 'package:app/views/profile/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainBottomButtons extends StatefulWidget {
  final int selectedIndex;
  const MainBottomButtons({super.key,required this.selectedIndex,});

  @override
  State<MainBottomButtons> createState() => _MainBottomButtonsState();
}

class _MainBottomButtonsState extends State<MainBottomButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      padding: EdgeInsetsDirectional.only(
        start: 16.w,
        end: 16.w,
        bottom: 0.h,
        top: 0.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              if(widget.selectedIndex == -1){
                showModalBottomSheet(
                  backgroundColor: blackLight,
                  barrierColor: secondaryColor.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(
                        24.w,
                      ),
                    ),
                  ),
                  context: context,
                  builder: (context) => StatefulBuilder(
                    builder: (context, setState) {
                      return OptionsScanMenu();
                    },
                  ),
                  isScrollControlled: true,
                );
              }else{
                Get.offAll(()=> HomeScreen());
              }
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(
                  40.r,
                ),
              ),
              child: Center(
                child: CustomImage(
                  image: ASSETS_ICONS + "scan.svg",
                  imageWidth: 24.w,
                  imageHeight: 24.w,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 45.w,
          ),
          InkWell(
            onTap: (){
              Get.offAll(()=> NotificationsScreen());
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImage(
                  image: ASSETS_ICONS + "bell.svg",
                  imageHeight: 24.w,
                  imageWidth: 24.w,
                  color: widget.selectedIndex == 0 ? white : null,
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomText(
                  "notifications",
                  textColor: widget.selectedIndex == 0 ? white : silverLight2,
                  fontFamily: PRIMARY_FONT_REGULAR,
                  fontSize: 14,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 45.w,
          ),
          InkWell(
            onTap: (){
              Get.offAll(()=> MessagesScreen());
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImage(
                  image: ASSETS_ICONS + "email.svg",
                  imageHeight: 24.w,
                  imageWidth: 24.w,
                  color: widget.selectedIndex == 1 ? white : null,
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomText(
                  "messages",
                  textColor: widget.selectedIndex == 1 ? white : silverLight2,
                  fontFamily: PRIMARY_FONT_REGULAR,
                  fontSize: 14,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 45.w,
          ),
          InkWell(
            onTap: (){
              Get.offAll(()=> ProfileScreen());
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImage(
                  image: ASSETS_ICONS + "user.svg",
                  imageHeight: 24.w,
                  imageWidth: 24.w,
                  color: widget.selectedIndex == 2 ? white : null,
                ),
                SizedBox(
                  height: 8.h,
                ),
                CustomText(
                  "profile",
                  textColor: widget.selectedIndex == 2 ? white : silverLight2,
                  fontFamily: PRIMARY_FONT_REGULAR,
                  fontSize: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
