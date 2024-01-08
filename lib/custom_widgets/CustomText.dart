import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/utils/language.dart';

class CustomText extends StatelessWidget {
  String text;
  bool translate;
  double fontSize;
  String fontFamily;
  FontWeight fontWeight;
  Color textColor;
  int lines;
  TextAlign textAlign;
  bool paragraph;
  bool isOffer;
  TextOverflow textOverflow;
  double fontHeight;
  TextDecoration? decoration;

  CustomText(
    this.text, {
    this.fontSize = 14,
    this.fontFamily = PRIMARY_FONT_REGULAR,
    this.fontWeight = FontWeight.normal,
    this.textColor = black1,
    this.translate = true,
    this.lines = 1,
    this.textAlign = TextAlign.start,
    this.paragraph = false,
    this.isOffer = false,
    this.textOverflow = TextOverflow.clip,
    this.fontHeight = 1.4,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      translate ? getTranslated(context, text) : text,
      textAlign: textAlign,
      maxLines: paragraph ? null : lines,
      overflow: textOverflow,
      style: TextStyle(
        decoration: isOffer ? TextDecoration.lineThrough : decoration,
        fontSize: fontSize.sp,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        color: textColor,
        height: fontHeight,
      ),
    );
  }
}
