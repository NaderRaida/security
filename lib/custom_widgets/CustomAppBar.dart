import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/LanguageController.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/singleton/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? driverId;
  final Color backColor;
  final Color titleColor;
  final bool translated;
  final bool isBack;
  final Function? backCallBack;

  CustomAppBar({
    this.title,
    this.driverId,
    this.backColor = white,
    this.titleColor = black,
    this.translated = true,
    this.isBack = true,
    this.backCallBack,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 16.h);
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ChromeSettingsForSpecificScreen.whiteChromeSetting(),
      child: SafeArea(
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.only(
              top: 28.h,
            ),
            child: CustomText(
              title!,
              translate: translated,
              textColor: titleColor,
              textAlign: TextAlign.center,
              fontSize: 17,
              fontFamily: PRIMARY_FONT_BOLD,
              fontHeight: 1,
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: backColor,
          leadingWidth: null,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Container(
              width: double.infinity,
              height: 1.h,
              color: blackLight,
            ),
          ),
          leading: isBack ?
          Container(
            padding: EdgeInsetsDirectional.only(start: 10.0.w,top: 25.h,),
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                if (isBack) {
                  backCallBack!();
                }
              },
              icon: Center(
                child: SvgPicture.asset(
                  ASSETS_IMAGES + "back_arrow.svg",
                  width: 20.w,
                  height: 16.h,
                  matchTextDirection: true,
                ),
              ),
            ),
          ) :
          SizedBox(),
          actions: [],
        ),
      ),
    );
  }
}
