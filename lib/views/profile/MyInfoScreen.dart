import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/custom_widgets/ButtonApp.dart';
import 'package:app/custom_widgets/CustomAppBar.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/custom_widgets/LoadingApp.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/views/home/HomeScreen.dart';
import 'package:app/views/profile/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../custom_widgets/CustomTextField.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({super.key});

  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  FocusNode userNameFocus = FocusNode();
  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();
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
                    title: "myInfo",
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
                                    CustomText(
                                      "userName",
                                      textColor: antiFlashColor,
                                      fontSize: 14,
                                      fontFamily: PRIMARY_FONT_REGULAR,
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    CustomTextField(
                                      "userNameHint",
                                      userName,
                                      userNameFocus,
                                      firstNameFocus,
                                      FULL_NAME,
                                      onDone: (value){
                                        setState(() {

                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              "firstName",
                                              textColor: antiFlashColor,
                                              fontSize: 14,
                                              fontFamily: PRIMARY_FONT_REGULAR,
                                            ),
                                            SizedBox(
                                              height: 12.h,
                                            ),
                                            SizedBox(
                                              width: 173.w,
                                              child: CustomTextField(
                                                "",
                                                firstName,
                                                firstNameFocus,
                                                lastNameFocus,
                                                FULL_NAME,
                                                translate: false,
                                                checkLength: false,
                                                onDone: (value){
                                                  setState(() {

                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              "lastName",
                                              textColor: antiFlashColor,
                                              fontSize: 14,
                                              fontFamily: PRIMARY_FONT_REGULAR,
                                            ),
                                            SizedBox(
                                              height: 12.h,
                                            ),
                                            SizedBox(
                                              width: 173.w,
                                              child: CustomTextField(
                                                "",
                                                lastName,
                                                lastNameFocus,
                                                mobileFocus,
                                                FULL_NAME,
                                                checkLength: false,
                                                translate: false,
                                                onDone: (value){
                                                  setState(() {

                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    CustomText(
                                      "mobile",
                                      textColor: antiFlashColor,
                                      fontSize: 14,
                                      fontFamily: PRIMARY_FONT_REGULAR,
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    CustomTextField(
                                      "mobileHint",
                                      mobile,
                                      mobileFocus,
                                      emailFocus,
                                      MOBILE,
                                      onDone: (value){
                                        setState(() {

                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    CustomText(
                                      "email",
                                      textColor: antiFlashColor,
                                      fontSize: 14,
                                      fontFamily: PRIMARY_FONT_REGULAR,
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    CustomTextField(
                                      "example@example.com",
                                      email,
                                      emailFocus,
                                      null,
                                      EMAIL,
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
    return userName.text.isNotEmpty && firstName.text.isNotEmpty &&
        lastName.text.isNotEmpty && email.text.isNotEmpty &&
        mobile.text.isNotEmpty;
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
