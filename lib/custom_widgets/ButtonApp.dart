import 'package:app/constants/colors.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonApp extends StatefulWidget {
  final double? width;
  final double? height;
  final Color color;
  final String? fontFamily;
  final String? text;
  final Color? textColor;
  final Color? borderColor;
  final bool translate;
  final double? fontSize;
  final Function? function;
  List<double> radius;
  final double fontHeight;
  final double topPadding;
  final double bottomPadding;
  final Widget? icon;

  ButtonApp({
    this.width,
    this.height = 60,
    this.color = primaryColor,
    this.borderColor,
    this.textColor,
    this.text,
    this.translate = true,
    this.fontFamily,
    this.function,
    this.fontSize,
    this.radius = const [10.0,10.0,10.0,10.0],
    this.fontHeight = 1.4,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.icon,
  });

  @override
  _ButtonAppState createState() => _ButtonAppState();
}

class _ButtonAppState extends State<ButtonApp> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      splashFactory: NoSplash.splashFactory,
      foregroundColor: widget.textColor,
      backgroundColor: widget.color,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(widget.radius[0]),
          topEnd: Radius.circular(widget.radius[1]),
          bottomEnd: Radius.circular(widget.radius[2]),
          bottomStart: Radius.circular(widget.radius[3]),
        ),
        side: BorderSide(
          width: 1.w,
          color: widget.borderColor != null ? widget.borderColor! : Colors.transparent,
        ),
      ),
      padding: EdgeInsetsDirectional.only(
        top: widget.topPadding,
        bottom: widget.bottomPadding,
      ),
    );
    return ElevatedButton(
      style: raisedButtonStyle,
      onPressed: widget.function == null ? null : (){
        widget.function!();
      },
      child: Container(
        width: widget.width != null ? widget.width! : null,
        height: widget.height != null ? widget.height!.h : null,
        alignment: AlignmentDirectional.center,
        child: Transform.translate(
          offset: Offset(0.0,2.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(widget.icon != null)...[
                widget.icon!,
                SizedBox(
                  width: 5.w,
                ),
              ],
              CustomText(
                widget.text!,
                translate: widget.translate,
                textColor: widget.textColor!,
                fontFamily: widget.fontFamily!,
                fontSize: widget.fontSize!.sp,
                fontHeight: widget.fontHeight,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
