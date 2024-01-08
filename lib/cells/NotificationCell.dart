import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/custom_widgets/CustomImage.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationCell extends StatelessWidget {
  final bool read;
  const NotificationCell({super.key,this.read = false,});

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
        bottom: 18.h,
        top: 18.h,
      ),
      margin: EdgeInsetsDirectional.only(
        bottom: 8.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomImage(
            image: ASSETS_ICONS + "bell_icon.svg",
            imageWidth: 24.w,
            imageHeight: 24.w,
            color: read ? darkSilver : white,
          ),
          SizedBox(
            width: 11.w,
          ),
          SizedBox(
            width: 255.w,
            child: CustomText(
              "تم تسجيل الدخول بنجاح للبوابة 3 الشرقية",
              translate: false,
              fontSize: 14,
              fontFamily: read ? PRIMARY_FONT_REGULAR : PRIMARY_FONT_SEMI_BOLD,
              textColor: read ? lightSilver : white,
              paragraph: true,
            ),
          ),
        ],
      ),
    );
  }
}
