import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/custom_widgets/CustomImage.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/views/chat/ChattingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GateCell extends StatelessWidget {
  GateCell({super.key,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(()=> ChattingScreen(myData: {}, otherData: {}));
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: EdgeInsetsDirectional.only(
          start: 16.w,
          end: 16.w,
          bottom: 9.h,
          top: 9.h,
        ),
        margin: EdgeInsetsDirectional.only(
          bottom: 12.h,
        ),
        decoration: BoxDecoration(
          color: blackLight,
          borderRadius: BorderRadius.circular(
           10.r,
          ),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomImage(
              image: ASSETS_IMAGES + "tmp.png",
              imageWidth: 52.w,
              imageHeight: 52.w,
            ),
            SizedBox(
              width: 12.w,
            ),
            SizedBox(
              width: 190.w,
              child: CustomText(
                "محمد الهاجري",
                translate: false,
                fontSize: 14,
                fontFamily: PRIMARY_FONT_REGULAR,
                textColor: white,
                paragraph: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
