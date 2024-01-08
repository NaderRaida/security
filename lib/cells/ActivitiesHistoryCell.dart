import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ActivitiesHistoryCell extends StatelessWidget {
  int index;
  ActivitiesHistoryCell({super.key,required this.index,});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: blackLight,
        borderRadius: BorderRadius.circular(
          10.r,
        ),
      ),
      padding: EdgeInsetsDirectional.only(
        start: 4.w,
        end: 4.w,
        bottom: 4.h,
        top: 4.h,
      ),
      margin: EdgeInsetsDirectional.only(
        bottom: 8.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(
               6.r,
              ),
            ),
            child: Center(
              child: CustomText(
                index == 0 ? "دخول" : index == 1 ? "خروج" : "استراحة",
                translate: false,
                fontSize: 14,
                fontFamily: PRIMARY_FONT_MEDIUM,
                textColor: lightSilver,
              ),
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 255.w,
                child: CustomText(
                  "تم تسجيل الدخول على بوابة 3 الشرقية",
                  translate: false,
                  fontSize: 14,
                  fontFamily: PRIMARY_FONT_MEDIUM,
                  textColor: white,
                  paragraph: true,
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              SizedBox(
                width: 255.w,
                child: CustomText(
                  "اليوم الساعة 12:30 م",
                  translate: false,
                  fontSize: 12,
                  fontFamily: PRIMARY_FONT_MEDIUM,
                  textColor: darkSilver,
                  paragraph: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
