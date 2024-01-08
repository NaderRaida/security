import 'package:app/cells/StatisticsCell.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/custom_widgets/CustomAppBar.dart';
import 'package:app/custom_widgets/LoadingApp.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/views/statistics/GatesScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
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
                    title: "statistics",
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
                      enablePullUp: false,
                      controller: refreshController,
                      onRefresh: onRefresh,
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: 16.w,
                                end: 4.w,
                                bottom: 0.h,
                                top: 34.h,
                              ),
                              child: GridView.count(
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                childAspectRatio: 1.4,
                                children: List.generate(15, (index) {
                                  return InkWell(
                                    onTap: (){
                                      if(index == 0){
                                        Get.to(()=> GatesScreen());
                                      }
                                    },
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: StatisticsCell(),
                                  );
                                },
                                ),
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
}
