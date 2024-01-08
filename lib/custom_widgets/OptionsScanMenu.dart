import 'package:app/cells/OptionItemCell.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/custom_widgets/CustomImage.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/views/scan/ScanScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OptionsScanMenu extends StatefulWidget {
  const OptionsScanMenu({super.key});

  @override
  State<OptionsScanMenu> createState() => _OptionsScanMenuState();
}

class _OptionsScanMenuState extends State<OptionsScanMenu> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ChromeSettingsForSpecificScreen.bottomSheetSettings(),
      child: Container(
        height: 460.h,
        decoration: BoxDecoration(
          color: blackLight,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r,),
            topRight: Radius.circular(24.r,),
          ),
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.1),
              blurRadius: 24,
              spreadRadius: 5,
              offset: Offset(0, -10),
            )
          ],
        ),
        padding: EdgeInsetsDirectional.only(
          start: 16.w,
          end: 16.w,
          bottom: 0.h,
          top: 16.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween ,
              children: [
                CustomText(
                  "options",
                  textColor: white,
                  fontFamily: PRIMARY_FONT_REGULAR,
                  fontSize: 16,
                ),
                InkWell(
                  onTap: (){
                    Get.back();
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: CustomImage(
                    image: ASSETS_ICONS + "close_arrow.svg",
                    imageWidth: 40.w,
                    imageHeight: 40.w,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            OptionItemCell(onTap: (){Get.back();Get.to(()=>ScanScreen());}, name: "login",),
            OptionItemCell(onTap: (){Get.back();Get.to(()=>ScanScreen());}, name: "prayRest",),
            OptionItemCell(onTap: (){Get.back();Get.to(()=>ScanScreen());}, name: "rest",),
            OptionItemCell(onTap: (){Get.back();Get.to(()=>ScanScreen());}, name: "changeLocation",),
            OptionItemCell(onTap: (){Get.back();Get.to(()=>ScanScreen());}, name: "endWork",),
          ],
        ),
      ),
    );
  }


}
