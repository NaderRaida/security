import 'package:app/cells/GateCell.dart';
import 'package:app/constants/colors.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/custom_widgets/CustomAppBar.dart';
import 'package:app/custom_widgets/LoadingApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../extensions/ChromeSettingsForSpecificScreen.dart';

class GatesScreen extends StatefulWidget {
  const GatesScreen({super.key});

  @override
  State<GatesScreen> createState() => _GatesScreenState();
}

class _GatesScreenState extends State<GatesScreen> {
  RefreshController refreshController = RefreshController(initialRefresh: false);
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
                    title: "بوابة 8 شرقي",
                    translated: false,
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
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      controller: refreshController,
                      onRefresh: onRefresh,
                      onLoading: onLoading,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: 16.w,
                                end: 16.w,
                                bottom: 0.h,
                                top: 34.h,
                              ),
                              child: ListView.builder(
                                itemCount: 11,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder:(BuildContext context,int index){
                                  return GateCell();
                                },
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

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  void onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
    refreshController.loadNoData();
    refreshController.loadComplete();
  }
}
