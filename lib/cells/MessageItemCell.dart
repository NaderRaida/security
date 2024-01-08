import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/custom_widgets/CustomImage.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/views/chat/ChattingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MessageItemCell extends StatelessWidget {
  bool read;
  MessageItemCell({super.key,this.read = false,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(()=> ChattingScreen(
          myData: {},
          otherData: {},
        ));
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: EdgeInsetsDirectional.only(
          start: 16.w,
          end: 16.w,
          bottom: 12.h,
          top: 12.h,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomImage(
                  image: ASSETS_IMAGES + "tmp.png",
                  imageWidth: 56.w,
                  imageHeight: 56.w,
                ),
                SizedBox(
                  width: 12.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 190.w,
                      child: CustomText(
                        "محمد الهاجري",
                        translate: false,
                        fontSize: 14,
                        fontFamily: read ? PRIMARY_FONT_REGULAR : PRIMARY_FONT_BOLD,
                        textColor: white,
                        paragraph: true,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      width: 190.w,
                      child: CustomText(
                        "السلام عليكم، هل أنت متواجد...",
                        translate: false,
                        fontSize: 12,
                        fontFamily: read ? PRIMARY_FONT_REGULAR : PRIMARY_FONT_SEMI_BOLD,
                        textColor: read ? lightSilver : white,
                        paragraph: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomText(
                  "8:30 ص",
                  translate: false,
                  fontSize: 12,
                  fontFamily: PRIMARY_FONT_REGULAR,
                  textColor: white,
                ),
                SizedBox(
                  height: 12.h,
                ),
                read ? SizedBox(
                  width: 20.w,
                  height: 20.w,
                ) :
                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                     20.r,
                    ),
                    color: primaryColor,
                  ),
                  child: Center(
                    child: CustomText(
                      "2",
                      translate: false,
                      fontSize: 13,
                      fontFamily: PRIMARY_FONT_BOLD,
                      textColor: white,
                      fontHeight: 1.6,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
