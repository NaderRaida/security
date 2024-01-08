import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/controller/LanguageController.dart';
import 'package:app/custom_widgets/ButtonApp.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/custom_widgets/LoadingApp.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/singleton/AppStorage.dart';
import 'package:app/singleton/dio.dart';
import 'package:app/views/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class CustomAlertDialog extends StatefulWidget {
  final int type;
  final String? message;
  final String? title;
  final Function? onPressed;
  bool withYesNoTitleButton;
  String? positiveTitle;
  String? negativeTitle;
  Color? positiveColor;
  Color? negativeColor;
  Function? positiveOnTap;
  Function? negativeOnTap;
  double? messageSize;
  String? messageFontFamily;
  CustomAlertDialog(
      this.type, {
        this.message,
        this.title,
        this.onPressed,
        this.withYesNoTitleButton = false,
        this.positiveTitle,
        this.negativeTitle,
        this.positiveOnTap,
        this.negativeOnTap,
        this.positiveColor,
        this.negativeColor,
        this.messageSize,
        this.messageFontFamily,
      });

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: ChromeSettingsForSpecificScreen.alertDialogChromeSetting(),
      child: widget.type == DELETE_DIALOG || widget.type == LOGOUT_DIALOG ?
      Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 27.w),
        backgroundColor: white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0.w)),
        child: IntrinsicHeight(
          child: SizedBox(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 30.h, bottom: 30.h, left: 21.w, right: 21.w),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Center(
                            child: CustomText(
                              widget.message!,
                              fontSize: 16,
                              fontFamily: PRIMARY_FONT_REGULAR,
                              textColor: gray0,
                              paragraph: true,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: 26.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 135.w,
                              height: 52.0.h,
                              child: ButtonApp(
                                  text: widget.type == LOGOUT_DIALOG || widget.withYesNoTitleButton ? "yes":"ok",
                                  width: 2.0.sw,
                                  textColor: white,
                                  color: primaryColor,
                                  fontFamily: PRIMARY_FONT_BOLD,
                                  fontSize: 16,
                                  function: widget.onPressed),
                            ),
                            SizedBox(
                              width: 135.w,
                              height: 52.0.h,
                              child: ButtonApp(
                                text: widget.type == LOGOUT_DIALOG || widget.withYesNoTitleButton ? "no":"cancel",
                                width: 2.0.sw,
                                textColor: customBlack,
                                color: gray,
                                fontFamily: PRIMARY_FONT_BOLD,
                                fontSize: 16,
                                function: () => Get.back(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if(Get.find<GeneralController>().isLoading)
                      Center(
                        child: LoadingApp(
                          width: 50.0,
                          height: 50.0,
                        ),
                      )
                  ],
                ),
              )),
        ),
      ) :
      widget.type == DECISION_DIALOG ?
      Dialog(
        alignment: Alignment.center,
        insetPadding: EdgeInsets.symmetric(
          vertical: 130.h,
          horizontal: 27.w,
        ),
        backgroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            12.0.w,
          ),
        ),
        child: IntrinsicHeight(
          child: SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 48.h,
                  horizontal: 15.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(widget.title != null)...[
                      Center(
                        child: CustomText(
                          widget.title!,
                          fontSize: 16,
                          fontFamily: PRIMARY_FONT_REGULAR,
                          textColor: black,
                          textAlign: TextAlign.start,
                          fontHeight: 1.4,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                    ],
                    Center(
                      child: CustomText(
                        widget.message!,
                        fontSize: widget.messageSize ?? 18,
                        fontFamily: widget.messageFontFamily ?? PRIMARY_FONT_REGULAR,
                        textColor: black,
                        paragraph: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 26.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonApp(
                          text: widget.positiveTitle,
                          width: 140.w,
                          height: 38,
                          textColor: white,
                          color: widget.positiveColor ?? primaryColor,
                          fontFamily: PRIMARY_FONT_REGULAR,
                          fontSize: 16,
                          function: widget.positiveOnTap,
                          radius: [0,0,0,0],
                        ),
                        ButtonApp(
                          text: widget.negativeTitle,
                          width: 140.w,
                          height: 38,
                          textColor: white,
                          color: widget.negativeColor ?? black,
                          fontFamily: PRIMARY_FONT_REGULAR,
                          fontSize: 16,
                          function: widget.negativeOnTap,
                          radius: [0,0,0,0],
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ) :
      widget.type == UN_AUTH_DIALOG ?
      Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: 25.w,
        ),
        backgroundColor: white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0.w)),
        child: IntrinsicHeight(
          child: SizedBox(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                top: 42.0.h,
                bottom: 42.h,
                start: 17.w,
                end: 17.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CustomText(
                  //   "un_auth_title",
                  //   fontSize: 16,
                  //   fontFamily: PRIMARY_FONT_BOLD,
                  //   textColor: black,
                  // ),
                  // SizedBox(
                  //   height: 7.h,
                  // ),
                  CustomText(
                    "unAuth",
                    fontSize: 14,
                    fontFamily: PRIMARY_FONT_REGULAR,
                    textColor: black,
                    paragraph: true,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ButtonApp(
                    width: 1.0.sw,
                    color: primaryColor,
                    fontFamily: PRIMARY_FONT_BOLD,
                    fontSize: 16,
                    textColor: white,
                    text: "login",
                    function: () {
                      Get.back();
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Get.offAll(() => HomeScreen());
                    },
                    child: Center(
                      child: CustomText(
                        "backHome",
                        fontSize: 12,
                        fontFamily: PRIMARY_FONT_REGULAR,
                        textColor: black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ) :
      widget.type == LANGUAGE_DIALOG ?
      Dialog(
        alignment: Alignment.center,
        insetPadding: EdgeInsets.symmetric(
          vertical: 130.h,
          horizontal: 27.w,
        ),
        backgroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            12.0.w,
          ),
        ),
        child: IntrinsicHeight(
          child: SizedBox(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 48.h,
                  horizontal: 15.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: (){
                        getIt<LanguageController>().changeLanguage(
                            Locale("ar"), () {
                          print("languageChanged successfully");
                          setState(() {
                            // initListItems();

                          });
                        });
                      },
                      child: Container(
                        padding: EdgeInsetsDirectional.only(
                          start: 14.w,
                          end: 14.w,
                          top: 16.h,
                          bottom: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppStorage().getLanguageCode() == "ar" ? primaryColor : gray,
                          borderRadius: BorderRadius.circular(
                            12.w,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(0.05),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: AppStorage().getLanguageCode() == "ar" ? MainAxisAlignment.spaceBetween :
                          MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomText(
                                  "arabic",
                                  fontSize: 16,
                                  fontFamily: PRIMARY_FONT_REGULAR,
                                  textColor: AppStorage().getLanguageCode() == "ar" ? white : black,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Image.asset(
                                  ASSETS_IMAGES + "ar.png",
                                  width: 23.w,
                                  height: 23.w,
                                ),
                              ],
                            ),
                            if(AppStorage().getLanguageCode() == "ar")
                              SvgPicture.asset(
                                ASSETS_ICONS + "check.svg",
                                width: 30.w,
                                height: 22.h,
                                color: white,
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: (){
                        getIt<LanguageController>().changeLanguage(
                            Locale("en"), () {
                          print("languageChanged successfully");

                        });
                      },
                      child: Container(
                        padding: EdgeInsetsDirectional.only(
                          start: 14.w,
                          end: 14.w,
                          top: 16.h,
                          bottom: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppStorage().getLanguageCode() == "en" ? primaryColor : gray,
                          borderRadius: BorderRadius.circular(
                            12.w,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: black.withOpacity(0.05),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: AppStorage().getLanguageCode() == "en" ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                          children: [
                            if(AppStorage().getLanguageCode() == "en")
                              SvgPicture.asset(
                                ASSETS_ICONS + "check.svg",
                                width: 30.w,
                                height: 22.h,
                                color: white,
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomText(
                                  "english",
                                  fontSize: 16,
                                  fontFamily: PRIMARY_FONT_REGULAR,
                                  textColor: AppStorage().getLanguageCode() == "en" ? white : black,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Image.asset(
                                  ASSETS_IMAGES + "en.png",
                                  width: 23.w,
                                  height: 23.w,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ) :
      Dialog(
        insetPadding: EdgeInsets.only(
            left: 25.w, right: 25.w),
        backgroundColor: white,
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(12.0.w)),
        child: IntrinsicHeight(
          child: SizedBox(
            child: Padding(
              padding: EdgeInsets.only(
                top: 30.0.h,
                bottom: 30.h,
                left: 21.w,
                right: 21.w,
              ),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Center(
                      child: CustomText(
                        widget.message!,
                        translate: false,
                        fontSize: 16,
                        //fontFamily: PRIMARY_FONT,
                        textColor: gray0,
                        paragraph: true,
                        textAlign:
                        TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 26.h),
                  Center(
                    child: SizedBox(
                      width: 300.w,
                      height: 52.h,
                      child: ButtonApp(
                        text: "ok",
                        width: 2.0.sw,
                        textColor: white,
                        color: primaryColor,
                        fontFamily:
                        PRIMARY_FONT_BOLD,
                        fontSize: 16,
                        function: () {
                          // Get.back();
                          if(widget.onPressed != null){
                            widget.onPressed!();
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}