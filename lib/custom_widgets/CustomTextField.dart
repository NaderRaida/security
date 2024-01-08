import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/utils/language.dart';
import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

import 'CustomText.dart';

class CustomTextField extends StatefulWidget {
  final String str;
  final bool translate;
  final TextEditingController? password;
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final FocusNode? previousFocusNode;
  final String? emptyError;
  final String? serverErrorMessage;
  final String? startIcon;
  final int type;
  final Function? onDone;
  final Function? onFieldSubmitted;
  final int lines;
  final bool enableValidation;
  final bool serverError;
  final bool doneButton;
  final bool fromRate;
  final bool withShadow;
  final bool isWebSite;
  final bool showFiledErrorRequired;
  final bool enabled;
  final bool url;
  final bool checkLength;
  final Color errorColor;
  final Color borderColor;
  final Color hintColor;
  final Color fillColor;
  final Color fontColor;
  final double hintSize;

  CustomTextField(
    this.str,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.type, {
    this.serverErrorMessage,
    this.startIcon,
    this.password,
    this.enableValidation = true,
    this.previousFocusNode,
    this.translate = true,
    this.isWebSite = false,
    this.showFiledErrorRequired = false,
    this.enabled = true,
    this.checkLength = true,
    this.lines = 1,
    this.onDone,
    this.onFieldSubmitted,
    this.serverError = false,
    this.doneButton = false,
    this.fromRate = false,
    this.withShadow = false,
    this.url = false,
    this.errorColor = redErrorColor,
    this.borderColor = Colors.transparent,
    this.hintColor = argentColor,
    this.fillColor = blackLight,
    this.fontColor = white,
    this.hintSize = 12.0,
    this.emptyError,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  bool value = false;
  bool fieldError = false;
  String? fieldErrorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            TextFormField(
              onChanged: (value) {
                if(widget.onDone != null){
                  widget.onDone!(value);
                }
                if (widget.type == CODE && value.isEmpty ||
                    value == "" ||
                    value.isEmpty) {
                  FocusScope.of(context)
                      .requestFocus(widget.previousFocusNode);
                  return;
                } else if (widget.type == CODE && value.length == 4) {
                  widget.onDone!(value);
                }
                if (value.length == 1 &&
                    value == "0" &&
                    widget.type == MOBILE) {
                  if(widget.onDone != null){
                    widget.onDone!(value);
                  }
                  //todo //in implementation onDone function to remove zero in the first number
                  // onDone: (value) {
                  //   userMobile.text = value.substring(1);
                  //   userMobile.selection =
                  //       TextSelection.fromPosition(TextPosition(offset: 1));
                  // },
                } else if (widget.type == SEARCH || widget.type == FULL_NAME) {
                  if(widget.onDone != null){
                    widget.onDone!(value);
                  }
                }
                /* else if (widget.type == CODE && value.length >= 1) {
                  FocusScope.of(context).requestFocus(widget.nextFocusNode);
                }*/
              },
              validator: (value) {
                if (value!.isEmpty) {
                  setState(() {
                    fieldError = true;
                    fieldErrorText =
                        getTranslated(context, widget.showFiledErrorRequired ? "this field required"
                            : widget.type == MOBILE ? "mobileIsRequired" :
                        widget.type == PASSWORD ? "passwordIsRequired" :
                        widget.type == EMAIL ? "emailIsRequired" :
                        widget.type == MESSAGE ? "messageIsRequired" :
                        widget.type == ADDRESS ? "addressIsRequired" :
                        widget.type == FULL_NAME ? "nameIsRequired"
                            : "this field required");
                  });
                  return "";
                } else if (value.length < 6 && widget.type == PASSWORD) {
                  setState(() {
                    fieldError = true;
                    fieldErrorText = getTranslated(context,
                        'Password_must_contain_at_least_6_characters');
                  });
                  return "";
                } else if (widget.checkLength && value.trim().length < 7 && widget.type == FULL_NAME) {
                  setState(() {
                    fieldError = true;
                    fieldErrorText = getTranslated(context,
                        'username_must_contain_at_least_7_characters');
                  });
                  return "";
                } else if (widget.type == EMAIL && !GetUtils.isEmail(value)) {
                  setState(() {
                    fieldError = true;
                    fieldErrorText =
                        getTranslated(context, 'Email is not valid');
                  });
                  return "";
                } else if (widget.type == MOBILE && value.length < 10) {
                  setState(() {
                    fieldError = true;
                    fieldErrorText =
                        getTranslated(context, 'incorrectPhoneNum');
                  });
                  return "";
                }
                else if (widget.type == ADDRESS){
                  setState(() {
                    fieldError = false;
                  });
                }
                else {
                  setState(() {
                    fieldError = false;
                    fieldErrorText = "";
                  });
                }
                return null;
              },
              keyboardType: widget.url ? TextInputType.url
                  : widget.type == EMAIL
                  ? TextInputType.emailAddress
                  : widget.type == MOBILE || widget.type == CODE
                      ? TextInputType.phone
                      : widget.type == PASSWORD ||
                              widget.type == CONFIRM_PASSWORD
                          ? TextInputType.visiblePassword
                          : widget.type == POINTS
                              ? TextInputType.number
                              : widget.type == MESSAGE
                                  ? TextInputType.multiline
                                  : widget.isWebSite ? TextInputType.url : TextInputType.text,
              cursorColor: primaryColor,
              controller: widget.controller,
              focusNode: widget.focusNode,
              textAlign: widget.fromRate ? TextAlign.center : TextAlign.start,
              obscureText: (_obscureText &&
                      (widget.type == PASSWORD ||
                          widget.type == CONFIRM_PASSWORD))
                  ? true
                  : false,
              obscuringCharacter: '●',
              maxLength: widget.type == MOBILE
                  ? 10
                  : widget.type == CODE
                      ? 4
                      : widget.type == PROMO_CODE
                          ? 8
                          : null,
              maxLines: widget.lines,
              style: TextStyle(
                  color: widget.fontColor,
                  fontFamily: PRIMARY_FONT_BOLD,
                  height: 1.2,
                  fontSize: 16.sp,
              ),
              textAlignVertical: widget.fromRate ? TextAlignVertical.center : null,
              textInputAction:
                  widget.type == CODE || widget.type == PROMO_CODE
                      ? TextInputAction.send
                      : widget.type == MESSAGE
                          ? widget.doneButton ? TextInputAction.done
                      : TextInputAction.newline
                          : (widget.focusNode != widget.nextFocusNode) &&
                                  widget.nextFocusNode != null
                              ? TextInputAction.next
                              : TextInputAction.done,
              inputFormatters:  [
                if(widget.type != FULL_NAME && widget.type != MESSAGE)
                  FilteringTextInputFormatter.deny(
                    emojiReg,
                  ),
                if(widget.type == MOBILE)
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
              ],
              enabled: widget.enabled,
              decoration: InputDecoration(
                focusColor: black,
                hoverColor: black,
                filled: true,
                fillColor: widget.fillColor,
                counterText: "",
                errorText: null,
                errorStyle: TextStyle(
                  height: 0,
                  color: Colors.transparent,
                  fontSize: 9.sp,
                ),
                contentPadding: EdgeInsetsDirectional.only(
                  top: widget.type == MESSAGE ? 30.h : 0.0,
                  start: widget.startIcon != null ? 44.w : 16.w,
                  end: widget.type == MOBILE ? 120.w : 20.w,
                ),
                hintText: widget.translate
                    ? getTranslated(context, widget.str)
                    : widget.str,
                hintStyle: TextStyle(
                    color: widget.hintColor,
                    fontFamily: PRIMARY_FONT_REGULAR,
                    fontWeight: FontWeight.normal,
                    height: widget.fromRate ? 1.4 : 1.2,
                    fontSize: widget.hintSize.sp,
                ),
                border: DecoratedInputBorder(
                  child: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.w),
                    borderSide: BorderSide(
                      color: widget.borderColor,
                      width: 1.w,
                    ),
                  ),
                  shadow: !widget.withShadow ? [] : [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.07),
                      blurRadius: 5,
                    )
                  ],
                ),
                enabledBorder: DecoratedInputBorder(
                  child: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.w),
                    borderSide: BorderSide(
                      color: widget.borderColor,
                      width: 1.w,
                    ),
                  ),
                  shadow: !widget.withShadow ? [] : [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.07),
                      blurRadius: 5,
                    )
                  ],
                ),
                disabledBorder: DecoratedInputBorder(
                  child: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.w),
                    borderSide: BorderSide(
                      color: widget.borderColor,
                      width: 1.w,
                    ),
                  ),
                  shadow: !widget.withShadow ? [] : [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.07),
                      blurRadius: 5,
                    )
                  ],
                ),
                focusedBorder: DecoratedInputBorder(
                  child: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.w),
                    borderSide: BorderSide(
                      color: widget.borderColor,
                      width: 1.w,
                    ),
                  ),
                  shadow: !widget.withShadow ? [] : [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.07),
                      blurRadius: 5,
                    )
                  ],
                ),
                focusedErrorBorder: DecoratedInputBorder(
                  child: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.w),
                    borderSide: BorderSide(
                      color: widget.errorColor,
                      width: 1.w,
                    ),
                  ),
                  shadow: !widget.withShadow ? [] : [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.07),
                      blurRadius: 5,
                    )
                  ],
                ),
                errorBorder: DecoratedInputBorder(
                  child: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.w),
                    borderSide: BorderSide(
                      color: widget.errorColor,
                      width: 1.w,
                    ),
                  ),
                  shadow: !widget.withShadow ? [] : [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.07),
                      blurRadius: 5,
                    )
                  ],
                ),
              ),
              onEditingComplete: () {
                print("onEditingComplete");
                (widget.focusNode != widget.nextFocusNode)
                    ? FocusScope.of(context)
                        .requestFocus(widget.nextFocusNode)
                    : widget.focusNode.unfocus();
              },
              onFieldSubmitted: (value) {
                if (widget.nextFocusNode == null) {
                  FocusScope.of(context).requestFocus(new FocusNode());
                }
                if (widget.type == CODE || widget.type == PROMO_CODE) {
                  widget.onFieldSubmitted!(value);
                }
              },
            ),
            if (widget.type == MOBILE)
              PositionedDirectional(
                end: 0,
                child: Container(
                  margin: EdgeInsetsDirectional.only(
                    end: 16.w,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 0.5.w,
                        color: blackLight1,
                        height: 64.h,
                      ),
                      SizedBox(
                        width: 32.w,
                      ),
                      CustomText(
                        "+966",
                        translate: false,
                        textColor: argentColor,
                        fontSize: 12,
                        fontFamily: PRIMARY_FONT_MEDIUM,
                      ),
                      SizedBox(
                        width: 9.w,
                      ),
                      SvgPicture.asset(
                        ASSETS_IMAGES + "sa_flag.svg",
                      )
                    ],
                  ),
                ),
              ),
            if (widget.startIcon != null)
              PositionedDirectional(
                start: 0,
                child: Container(
                  width: 20.w,
                  height: 20.w,
                  margin: EdgeInsetsDirectional.only(
                    start: 15.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      6.w,
                    ),
                    color: primaryColorLight,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      ASSETS_ICONS + widget.startIcon.toString(),
                      width: 11.w,
                      height: 14.h,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            if (widget.type == PASSWORD || widget.type == CONFIRM_PASSWORD)
              PositionedDirectional(
                end: 0,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                      start: 0.w,
                      end: 0.w,
                      top: 0.h,
                      bottom: ((value) ? 20.h : 0.h),
                  ),
                  child: suffix(),
                ),
              ),
            // if (widget.type == MOBILE)
            //   PositionedDirectional(
            //     end: 0,
            //     child: Padding(
            //       padding: EdgeInsetsDirectional.only(
            //         start: 0.w,
            //         end: 15.w,
            //         top: 0.h,
            //         bottom: ((value) ? 20.h : 0.h),
            //       ),
            //       child: CustomText(
            //         "966+",
            //         translate: false,
            //         textColor: blackCustom,
            //       ),
            //     ),
            //   ),
          ],
        ),
        if (fieldError)
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                start: 16.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomText(
                    fieldErrorText!,
                    fontFamily: PRIMARY_FONT_REGULAR,
                    fontSize: 10.sp,
                    textColor: widget.errorColor,
                    translate: false,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget suffix() {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 5.w),
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        icon: Center(
          child: SvgPicture.asset(
            ASSETS_ICONS + (_obscureText ? "eye1.svg" : "eye.svg"),
            // width: 24.w,
            // height: 24.w,
          ),
        ),
      ),
    );
  }
}
