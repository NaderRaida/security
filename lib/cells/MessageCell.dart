import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MessageCell extends StatefulWidget {
  final String? text;
  final String? type;
  final bool mine;
  final bool watch;
  final timestamp;
  final String? senderImage;
  final String? receiverImage;
  final Function? viewImageFullScreen;
  final bool sensitiveWards;
  final File? imageFile;
  final String? imageSourcePath;
  final bool uploadCompleted;
  final bool loadingUpload;
  final Function? reUploadImage;
  final bool isLast;
  final bool hideProfileImage;
  final String? audioTime;

  MessageCell(
      {Key? key,
        this.text,
        this.type,
        this.mine = false,
        this.watch = false,
        this.timestamp,
        this.senderImage,
        this.receiverImage,
        this.viewImageFullScreen,
        this.sensitiveWards = false,
        this.imageFile,
        this.imageSourcePath,
        this.uploadCompleted = false,
        this.loadingUpload = false,
        this.reUploadImage,
        this.isLast = false,
        this.hideProfileImage = false,
        this.audioTime,
      })
      : super(key: key);

  @override
  _MessageCellState createState() => _MessageCellState();
}

class _MessageCellState extends State<MessageCell> {

  String? year, month, day, hour, min;
  final Set<Marker> _markers = {};
  late GoogleMapController mapController;


  @override
  Widget build(BuildContext context) {
    return Container(
      // color: widget.mine ? white : red,
      margin: EdgeInsetsDirectional.only(
        bottom: 10.h,
      ),
      child: Column(
        crossAxisAlignment: widget.mine ?
        CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Directionality(
            textDirection: ui.TextDirection.rtl,
            child: IntrinsicWidth(
              stepWidth: 5.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async{
                          if(!widget.sensitiveWards){
                            try{
                              await launchUrlString(
                                widget.text.toString(),
                                mode: LaunchMode.externalApplication,
                              );
                            }catch(e){
                              print("can't launch the url");
                            }
                          }
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 14.0.h,
                              horizontal: 14.0.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                10.r,
                              ),
                              color: widget.mine ? primaryColor : blackLight1,
                            ),
                            child: Text(
                              widget.sensitiveWards /*&& AppStorage().getChatMonitoring() == 1 */ ?
                              getTranslated(context, 'thisTextHasBeenHiddenByAdministration') :
                              widget.text.toString(),
                              textAlign: TextAlign.start,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                color: white,
                                fontSize: 13.sp,
                                fontFamily: PRIMARY_FONT_REGULAR,
                                height: 1.4,
                              ),
                            )
                        ),
                      ),
                      if(!widget.mine)...[
                        SizedBox(
                          width: 10.w,
                        ),
                        underMessageBody(),
                      ],
                    ],
                  ),
                  if(widget.mine)
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Padding(
                        padding:  EdgeInsetsDirectional.only(end: 8.w),
                        child: underMessageBody(),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget underMessageBody(){
    return Text(
      "12:32 ص"/*widget.timestamp.toString()*/,
      style: TextStyle(
        color: gray,
        fontSize: 13.sp,
        fontFamily: PRIMARY_FONT_REGULAR,
      ),
      textAlign: TextAlign.start,
    );
  }
}