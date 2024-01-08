import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class StatisticsCell extends StatelessWidget {
  const StatisticsCell({super.key});

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
        start: 16.w,
        end: 16.w,
        bottom: 0.h,
        top: 0.h,
      ),
      margin: EdgeInsetsDirectional.only(
        end: 12.w,
        bottom: 16.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
