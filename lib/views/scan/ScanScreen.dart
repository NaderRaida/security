import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/custom_widgets/CustomAppBar.dart';
import 'package:app/custom_widgets/CustomImage.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/custom_widgets/LoadingApp.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  double scanArea = 310.0;
  String? errorText;
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
                  bottomNavigationBar: result == null ? bottomControl() : SizedBox(),
                  backgroundColor: secondaryColor,
                  appBar: CustomAppBar(
                    title: "scanQR",
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
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: 42.w,
                              end: 42.w,
                              bottom: 0.h,
                              top: result != null ? 200.h : 120.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: CustomText(
                                    "login1",
                                    fontSize: 18,
                                    fontFamily: PRIMARY_FONT_BOLD,
                                    textColor: white,
                                  ),
                                ),
                                SizedBox(
                                  height: result != null ? 32.h : 24.h,
                                ),
                                if(result != null)
                                  Center(
                                    child: Column(
                                      children: [
                                        CustomImage(
                                          image: ASSETS_IMAGES + "success.svg",
                                          imageWidth: 100.w,
                                          imageHeight: 100.w,
                                        ),
                                        SizedBox(
                                          height: 24.h,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              "تم تسجيل الدخول على بوابة:",
                                              translate: false,
                                              fontSize: 14,
                                              fontFamily: PRIMARY_FONT_REGULAR,
                                              textColor: white,
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            SizedBox(
                                              width: 130.w,
                                              child: CustomText(
                                                "بوابة 3 الشرقية",
                                                translate: false,
                                                fontSize: 14,
                                                fontFamily: PRIMARY_FONT_SEMI_BOLD,
                                                textColor: white,
                                                paragraph: true,
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                else...[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      35.r,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 310.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          35.r,
                                        ),
                                        // image: DecorationImage(
                                        //   fit: BoxFit.cover,
                                        //   image: AssetImage(
                                        //     ASSETS_IMAGES + "qr_decoration.png",
                                        //   ),
                                        // ),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          QRView(
                                            key: qrKey,
                                            onQRViewCreated: onQRViewCreated,
                                            overlay: QrScannerOverlayShape(
                                              borderColor: blackLight,
                                              borderRadius: 0,
                                              borderLength: 0,
                                              borderWidth: 0,
                                              cutOutSize: scanArea,
                                            ),
                                          ),
                                          CustomImage(
                                            image: ASSETS_IMAGES + "qr_decoration.png",
                                            imageWidth: double.infinity,
                                            imageHeight: 310.h,
                                            fit: BoxFit.fill,
                                            color: Colors.transparent,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if(errorText != null)...[
                                    SizedBox(
                                      height: 32.h,
                                    ),
                                    CustomText(
                                      errorText.toString(),
                                      textColor: redErrorColor,
                                      fontFamily: PRIMARY_FONT_SEMI_BOLD,
                                      fontSize: 14,
                                    ),
                                  ],
                                ],

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
          );
        }
    );
  }

  Widget bottomControl(){
    return Container(
      height: 105.h,
      padding: EdgeInsetsDirectional.only(
        start: 91.w,
        end: 0.w,
        bottom: 0.h,
        top: 0.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              toggleFlash();
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: CustomImage(
              image: ASSETS_ICONS + "flash_btn.svg",
              imageHeight: 40.w,
              imageWidth: 40.w,
            ),
          ),
          SizedBox(
            width: 32.w,
          ),
          CustomImage(
            image: ASSETS_ICONS + "capture.svg",
            imageHeight: 64.w,
            imageWidth: 64.w,
          ),
        ],
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        print("=>>>>>>>>> qr result:: ${scanData.code.toString()}");
        if(scanData.code != null && scanData.code!.isNotEmpty){
          result = scanData;
        }
      });
    }).onError((error){
      setState(() {
        errorText = "errorInQR";
      });
    });
  }


  void toggleFlash() async{
    if(controller != null){
      await controller!.toggleFlash();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
