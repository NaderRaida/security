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
import 'package:app/views/auth/RegisterScreen.dart';
import 'package:app/views/home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
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
                  isBack: false,
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
                                  height: 56.h,
                                ),
                                Center(
                                  child: Image.asset(
                                    ASSETS_IMAGES + "app_logo.png",
                                    width: 91.w,
                                    height: 76.w,
                                  ),
                                ),
                                SizedBox(
                                  height: 40.h,
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
                                  passwordFocus,
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
                                  null,
                                  PASSWORD,
                                  translate: false,
                                  onDone: (value){
                                    setState(() {

                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: InkWell(
                                    onTap: (){

                                    },
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: CustomText(
                                      "forgotPassword",
                                      textColor: white,
                                      fontSize: 12,
                                      fontFamily: PRIMARY_FONT_MEDIUM,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 170.h,
                                ),
                                ButtonApp(
                                  text: "createAccount",
                                  fontFamily: PRIMARY_FONT_REGULAR,
                                  fontSize: 16,
                                  textColor: primaryColor,
                                  color: Colors.transparent,
                                  borderColor: lightSilver,
                                  function: (){
                                    Get.to(()=> RegisterScreen());
                                  },
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                ButtonApp(
                                  text: "login",
                                  fontFamily: PRIMARY_FONT_BOLD,
                                  fontSize: 16,
                                  textColor: email.text.isNotEmpty && password.text.isNotEmpty ? white : darkSilver,
                                  color: email.text.isNotEmpty && password.text.isNotEmpty ? primaryColor : buttonDisabled,
                                  borderColor: email.text.isNotEmpty && password.text.isNotEmpty ? primaryColor : buttonDisabled,
                                  function: (){
                                    if(email.text.isNotEmpty && password.text.isNotEmpty){
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
}
