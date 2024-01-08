import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/custom_widgets/ButtonApp.dart';
import 'package:app/custom_widgets/CustomAppBar.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/custom_widgets/CustomTextField.dart';
import 'package:app/custom_widgets/LoadingApp.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/views/profile/ProfileScreen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

  FocusNode currentPasswordFocus = FocusNode();
  FocusNode newPasswordFocus = FocusNode();
  FocusNode confirmNewPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(
        init: GeneralController(),
        builder: (controller) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: ChromeSettingsForSpecificScreen.mainChromeSetting(),
            child: Container(
              color: secondaryColor,
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: secondaryColor,
                  bottomNavigationBar: bottomButton(),
                  appBar: CustomAppBar(
                    title: "changePassword",
                    titleColor: white,
                    isBack: true,
                    backCallBack: (){
                      Get.back();
                    },
                    backColor: secondaryColor,
                  ),
                  body: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return false;
                    },
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onPanDown: (_) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Form(
                        key: formKey,
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: 16.w,
                                  end: 16.w,
                                  bottom: 0.h,
                                  top: 0.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 32.h,
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    CustomText(
                                      "currentPassword",
                                      textColor: antiFlashColor,
                                      fontSize: 14,
                                      fontFamily: PRIMARY_FONT_REGULAR,
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    CustomTextField(
                                      "● ● ● ● ● ● ●",
                                      currentPassword,
                                      currentPasswordFocus,
                                      newPasswordFocus,
                                      PASSWORD,
                                      translate: false,
                                      onDone: (value){
                                        setState(() {

                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    CustomText(
                                      "newPassword",
                                      textColor: antiFlashColor,
                                      fontSize: 14,
                                      fontFamily: PRIMARY_FONT_REGULAR,
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    CustomTextField(
                                      "● ● ● ● ● ● ●",
                                      newPassword,
                                      newPasswordFocus,
                                      confirmNewPasswordFocus,
                                      PASSWORD,
                                      translate: false,
                                      onDone: (value){
                                        setState(() {

                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    CustomText(
                                      "confirmNewPassword",
                                      textColor: antiFlashColor,
                                      fontSize: 14,
                                      fontFamily: PRIMARY_FONT_REGULAR,
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    CustomTextField(
                                      "● ● ● ● ● ● ●",
                                      confirmNewPassword,
                                      confirmNewPasswordFocus,
                                      null,
                                      PASSWORD,
                                      translate: false,
                                      onDone: (value){
                                        setState(() {

                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if(controller.isLoading)
                              LoadingApp(
                                color: white,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  bool checkAllFields(){
    return currentPassword.text.isNotEmpty && newPassword.text.isNotEmpty &&
        confirmNewPassword.text.isNotEmpty;
  }

  Widget bottomButton(){
    return Container(
      height: 75.h,
      padding: EdgeInsetsDirectional.only(
        start: 16.w,
        end: 16.w,
        bottom: 0.h,
        top: 0.h,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          ButtonApp(
            text: "edit",
            fontFamily: PRIMARY_FONT_BOLD,
            fontSize: 16,
            textColor: checkAllFields() ? white : darkSilver,
            color: checkAllFields() ? primaryColor : buttonDisabled,
            borderColor: checkAllFields() ? primaryColor : buttonDisabled,
            function: (){
              if(checkAllFields()){
                if(formKey.currentState!.validate()){
                  Get.offAll(()=> ProfileScreen());
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
