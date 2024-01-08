import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/custom_widgets/CustomImage.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionItemCell extends StatelessWidget {
  final Function onTap;
  final String name;
  const OptionItemCell({super.key,required this.onTap,required this.name,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: EdgeInsetsDirectional.only(
          start: 16.w,
          end: 16.w,
          bottom: 19.h,
          top: 19.h,
        ),
        margin: EdgeInsetsDirectional.only(
          bottom: 8.h,
        ),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(
           10.r,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              name,
              textColor: white,
              fontFamily: PRIMARY_FONT_REGULAR,
              fontSize: 16,
            ),
            CustomImage(
              image: ASSETS_ICONS + "go_arrow1.svg",
              imageWidth: 24.w,
              imageHeight: 24.w,
            ),
          ],
        ),
      ),
    );
  }
}
