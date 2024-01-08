import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/custom_widgets/ButtonApp.dart';
import 'package:app/custom_widgets/CustomAppBar.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/custom_widgets/CustomTextField.dart';
import 'package:app/custom_widgets/LoadingApp.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/singleton/AppStorage.dart';
import 'package:app/views/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  FocusNode userNameFocus = FocusNode();
  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
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
                  appBar: CustomAppBar(
                    title: "register",
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
                                    height: 72.h,
                                  ),
                                  Center(
                                    child: Image.asset(
                                      ASSETS_IMAGES + "app_logo.png",
                                      width: 91.w,
                                      height: 76.w,
                                    ),
                                  ),
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
                                              emailFocus,
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
                                    mobileFocus,
                                    EMAIL,
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
                                    passwordFocus,
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
                                    "password",
                                    textColor: antiFlashColor,
                                    fontSize: 14,
                                    fontFamily: PRIMARY_FONT_REGULAR,
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  CustomTextField(
                                    "● ● ● ● ● ● ●",
                                    password,
                                    passwordFocus,
                                    confirmPasswordFocus,
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
                                    "confirmPassword",
                                    textColor: antiFlashColor,
                                    fontSize: 14,
                                    fontFamily: PRIMARY_FONT_REGULAR,
                                  ),
                                  SizedBox(
                                    height: 12.h,
                                  ),
                                  CustomTextField(
                                    "● ● ● ● ● ● ●",
                                    confirmPassword,
                                    confirmPasswordFocus,
                                    null,
                                    PASSWORD,
                                    translate: false,
                                    onDone: (value){
                                      setState(() {

                                      });
                                    },
                                  ),




                                  SizedBox(
                                    height: 32.h,
                                  ),
                                  ButtonApp(
                                    text: "createAccount2",
                                    fontFamily: PRIMARY_FONT_BOLD,
                                    fontSize: 16,
                                    textColor: checkAllFields() ? white : darkSilver,
                                    color: checkAllFields() ? primaryColor : buttonDisabled,
                                    borderColor: checkAllFields() ? primaryColor : buttonDisabled,
                                    function: (){
                                      if(checkAllFields()){
                                        if(formKey.currentState!.validate()){
                                          AppStorage().setUserType(CLIENT_USER);
                                          Get.offAll(()=> HomeScreen());
                                        }
                                      }
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
          );
        }
    );
  }

  bool checkAllFields(){
    return userName.text.isNotEmpty && firstName.text.isNotEmpty &&
        lastName.text.isNotEmpty && email.text.isNotEmpty &&
        mobile.text.isNotEmpty && password.text.isNotEmpty &&
        confirmPassword.text.isNotEmpty;
  }
}