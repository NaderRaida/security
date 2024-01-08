import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:app/cells/MessageCell.dart';
import 'package:app/constants/colors.dart';
import 'package:app/constants/constants.dart';
import 'package:app/controller/GeneralController.dart';
import 'package:app/controller/LanguageController.dart';
import 'package:app/custom_widgets/CustomAppBar.dart';
import 'package:app/custom_widgets/CustomImage.dart';
import 'package:app/custom_widgets/CustomText.dart';
import 'package:app/custom_widgets/LoadingApp.dart';
import 'package:app/extensions/ChromeSettingsForSpecificScreen.dart';
import 'package:app/singleton/AppStorage.dart';
import 'package:app/singleton/dio.dart';
import 'package:app/utils/language.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChattingScreen extends StatefulWidget {
  Map<String, dynamic> myData;
  Map<String, dynamic> otherData;
   ChattingScreen({
     super.key,
     required this.myData,
     required this.otherData,
   });

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final databaseReference = FirebaseDatabase.instance.ref();
  TextEditingController messageController = TextEditingController();
  String? messageControllerValue;
  FocusNode detailsMessageFocus = FocusNode();
  List<DocumentSnapshot>? docs;
  ScrollController scrollController = ScrollController();
  DateTime dateTime = DateTime.now();
  String? fifteenAgo;
  @override
    Widget build(BuildContext context) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: ChromeSettingsForSpecificScreen.chattingChromeSetting(),
        child: GetBuilder<GeneralController>(
          init: GeneralController(),
          builder: (controller) {
            return Container(
              color: secondaryColor,
              child: SafeArea(
                top: false,
                child: Scaffold(
                  backgroundColor: secondaryColor,
                  appBar: chatAppBar(),
                  body: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return true;
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 0.69.sh,
                          padding: EdgeInsetsDirectional.only(
                            start: 22.w,
                            end: 22.w,
                            bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 130.h : 0.h,
                          ),
                          margin: EdgeInsetsDirectional.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 0 : 135.h,
                          ),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: _fireStore
                                  .collection(CHAT_ROOT_PARENT)
                                  .doc(widget.otherData["chatId"])
                                  .collection("Messages|")
                              // .where('orderNumber', isEqualTo: widget.orderNumber,isNull: true)
                                  .orderBy("timestamp", descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.transparent,
                                      color: primaryColor,
                                    ),
                                  );
                                }
                                if(snapshot.data != null){
                                  docs = snapshot.data!.docs;
                                }
                                // if(runStatusCheck){
                                //   print("=>>> enter status check");
                                //   statusCheck();
                                // }
                                // docs!.removeWhere((element) => element.data() != null &&
                                //     ((element.data() as Map<String,dynamic>)['orderNumber'] == null || (element.data() as Map<String,dynamic>)['orderNumber'] != widget.orderNumber));
                                return true/*docs != null && docs!.length > 1*/ ?
                                SingleChildScrollView(
                                  controller: scrollController,
                                  child: ListView.builder(
                                    reverse: true,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    // itemCount: docs != null ? docs!.length == 1 ? 0 : docs!.length : 0,
                                    itemCount: 4,
                                    itemBuilder: (context, i) {
                                      Map<String,dynamic> data = /*docs![i].data() != null ?
                                      docs![i].data() as Map<String,dynamic> :*/ {};
                                      //todo Readable and unread message
                                      // readableAndUnread(docs![i]);
                                      //todo convert time to since time
                                      final loadedTime = DateTime.parse("2023-10-11 12:11:90.7"/*data['dateTime']*/);
                                      final now = new DateTime.now();
                                      final difference = now.difference(loadedTime);
                                      fifteenAgo = timeago.format(
                                        now.subtract(difference),
                                        locale: getIt<LanguageController>().appLocal.languageCode,
                                      );
                                      return false/*data['type'] == TEXT && data['text'].toString().isEmpty*/ ?
                                      SizedBox() :
                                      MessageCell(
                                        text:  i == 0 ? "تفضل ماذا تريد" : i == 1 ? "عليكم السلام , صحيح على البوابة" : i == 2 ? "هل أنت على البوابة ؟" : "السلام عليكم أحمد",
                                        type: "text",
                                        timestamp: fifteenAgo,// 15 minutes ago,
                                        watch: false,
                                        mine: i == 1 || i == 0,
                                        // senderImage: data['user_id'] == widget.myData['senderUserId'] ?
                                        // widget.myData['profileImage']: widget.otherData['profileImage'],
                                        // receiverImage: data['user_id'] == widget.myData['senderUserId'] ?
                                        // widget.myData['profileImage']: widget.otherData['profileImage'],
                                        isLast: i == (docs!.length - 1),
                                        audioTime: data['audioTime'],
                                      );
                                    },
                                  ),
                                ) :
                                Center(
                                  child: CustomText(
                                    "thereIsNoMessages",
                                    fontSize: 14,
                                    fontFamily: PRIMARY_FONT_REGULAR,
                                    textColor: white,
                                  ),
                                );
                              }
                          ),
                        ),
                        PositionedDirectional(
                          bottom: 0.h,
                          start: 0.w,
                          child: Container(
                            width: 1.sw,
                            height: 100.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.only(
                                topEnd: Radius.circular(10.w),
                                topStart: Radius.circular(10.w),
                              ),
                              color: blackLight1,
                            ),
                            padding: EdgeInsetsDirectional.only(
                              start: 22.w,
                              end: 22.w,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30.h,
                                ),
                                Container(
                                  height: 55.h,
                                  child: Stack(
                                    alignment: AlignmentDirectional.centerEnd,
                                    children: [
                                      SizedBox(
                                        height: 55.h,
                                        child: TextField(
                                          minLines: 1,
                                          maxLines: 4,
                                          style: TextStyle(
                                            fontFamily: PRIMARY_FONT_REGULAR,
                                            fontSize: 15.sp,
                                            color: white,
                                            height: 1,
                                          ),
                                          focusNode: detailsMessageFocus,
                                          onSubmitted: (value) {
                                            print("send chat");
                                            setState(() {
                                              sendChat(TEXT);
                                            });
                                          },
                                          onChanged: (value){
                                            setState(() {
                                              print("chat text field onChanged $value");
                                              if(value.trim().isEmpty){
                                                messageController.clear();
                                              }
                                            });
                                          },
                                          onTap: (){

                                          },
                                          controller: messageController,
                                          cursorColor: white,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsetsDirectional.only(
                                              top: 20.h,
                                              bottom: 20.h,
                                              start: 14.w,
                                              end: 90.w,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.r),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.r),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 0,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.r),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 0,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: blackLight,
                                            hintText: getTranslated(context, "enterMessageHere"),
                                            hintStyle: TextStyle(
                                              fontFamily: PRIMARY_FONT_REGULAR,
                                              fontSize: 13.sp,
                                              color: darkSilver,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: (){
                                          print("send chat");
                                          setState(() {
                                            sendChat(TEXT);
                                          });
                                        },
                                        child: Container(
                                          width: 75.w,
                                          margin: EdgeInsetsDirectional.only(
                                            start: 0.w,
                                            end: 3.w,
                                            bottom: 3.h,
                                            top: 3.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: messageController.text.isNotEmpty ? primaryColor : lightSilver,
                                            borderRadius: BorderRadius.circular(
                                             10.r,
                                            ),
                                          ),
                                          child: Center(
                                            child: CustomText(
                                              "send",
                                              fontSize: 14,
                                              fontFamily: PRIMARY_FONT_REGULAR,
                                              textColor: white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

  PreferredSizeWidget chatAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: secondaryColor,
      toolbarHeight: kToolbarHeight + 31.h,
      titleSpacing: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: 16.w,
              end: 16.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: white,
                    size: 23.w,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                   25.r,
                  ),
                  child: CustomImage(
                    image: ASSETS_IMAGES + "tmp.png",
                    imageWidth: 45.w,
                    imageHeight: 45.w,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      "محمد الواجدي",
                      translate: false,
                      textColor: white,
                      fontSize: 15,
                      fontHeight: 1,
                      fontFamily: PRIMARY_FONT_BOLD,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    StreamBuilder(
                        stream: databaseReference.child("active_users").child(widget.myData['receiverUserId'].toString()).onValue,
                        builder: (context,snapshot) {
                          dynamic values;
                          if(snapshot.hasData){
                            DatabaseEvent even = snapshot.data! as DatabaseEvent;
                            DataSnapshot dataSnapshot = even.snapshot;
                            if(dataSnapshot.value != null){
                              values = dataSnapshot.value;
                            }
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                snapshot.hasData && values != null && values['status'] ? "offline" : "online",
                                textColor: white,
                                fontSize: 13,
                                fontHeight: 1,
                                fontFamily: PRIMARY_FONT_REGULAR,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: BoxDecoration(
                                  color: snapshot.hasData && values != null && values['status'] ? redErrorColor : primaryColor,
                                  borderRadius: BorderRadius.circular(
                                    4.w,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            width: double.infinity,
            height: 1.h,
            color: blackLight1,
          ),
        ],
      ),
    );
  }
  Future<void> sendChat(String type, {String? messageId}) async {
    String text = messageController.text.trim();
    /* if(text.isNotEmpty){*/
    messageController.clear();
    /*}*/
    // if(getIt<AppSharedPreferences>().getChatMonitoring() == 1) {
    //   for (int i = 0; i < keyWords.length; i++) {
    //     sensitive.add(text.contains(keyWords[i].name));
    //     if (text.contains(keyWords[i].name)) {
    //       sensitiveWards = true;
    //     }
    //   };
    // }
    DateTime dateTime = DateTime.now();
    if (text.isNotEmpty) {
      if(type == TEXT){
        await _fireStore
            .collection(CHAT_ROOT_PARENT)
            .doc(widget.otherData["chatId"])
            .collection("Messages|")
            .add({
          'user_id': widget.myData['senderUserId'],
          'text': text,
          'watch': false,
          'type': type,
          'sensitiveWards': false,
          'timestamp': FieldValue.serverTimestamp(),
          'dateTime': dateTime.toString(),
          'audioTime': "0 : 0",
          'orderNumber': "",
        }).then((value) {
          sendNotification(
            false,
            text,
            widget.myData['fullName'],
            "user_${widget.myData['receiverUserId'].toString()}",
          );
          print("parent parent document id = " +
              value.parent.parent!.id +
              " documnet id = " + value.id);
          print('widget.myData[senderUserId] >>||> ${widget.otherData['senderUserId']}');
          Map<String, dynamic> data = {
            'chatModel': {
              'sender': {
                'id': widget.otherData['senderUserId'],
                'name': widget.otherData['fullName'],
                'image_url': widget.otherData['profileImage']
              },
              'receiver': {
                'id': widget.myData['senderUserId'],
                'name': widget.myData['fullName'],
                'image_url': widget.myData['profileImage']
              },
              'sender_and_receiver': [
                widget.otherData['senderUserId'],
                widget.myData['senderUserId'],
              ],
              'text': text,
              'sensitiveWards': false,
              'watch': false,
              'type': type,
              'timestamp': FieldValue.serverTimestamp(),
              'dateTime': dateTime.toString(),
              'chat_creator': widget.myData['chat_creator'],
              'chat_receiver': widget.myData['chat_receiver'],
              'orderNumber': "",
            }
          };
          _fireStore.collection(CHAT_ROOT_PARENT).doc(widget.otherData["chatId"]).update(data).then((value) {});
        });
      }
      setState(() {
        scrollChatToDown();
      });
    }
  }
  void scrollChatToDown({bool fromListener = false}) async{
    await Future.delayed(Duration(milliseconds: 830));
    if(scrollController.hasClients){
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeIn,
      );
    }
  }

  Future<void> sendNotification(bool isImage,subject,title,topicName) async {
    String serverToken;
    _fireStore
        .collection("Data").doc('ServerKey')
        .snapshots(includeMetadataChanges: false).first.then((value) async {
      serverToken = value.get('server_key');
      final postUrl = 'https://fcm.googleapis.com/fcm/send';

      String toParams = "/topics/"+'${kDebugMode || TEST_ENV ? "t_$topicName" : "$topicName"}';


      print("widget.otherData = "+json.encode(widget.otherData));
      print("subject notification ====>> $subject || ${subject.toString()}");
      final data = {
        'notification': {
          'body': isImage ? getTranslated(context, "sentYouImage") : subject,
          'title':title,
          'sound': 'default',
          'android_channel_id': 'channel id 3',
          if(isImage)"image": "$subject"
        },
        'android': {
          'priority': 'high',
          'notification': {
            'channel_id': 'channel id 3'
          }
        },
        'apns': {
          'headers': {
            'apns-priority': '5',
            'apns-push-type': 'background'
          },
          'payload': {
            'aps': {
              'sound': 'default',
              'content_available': true,
            }
          },
          if(isImage)"fcm_options": {
            "image": "$subject"
          }
        },
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'notification_foreground': 'true',
          'notification_android_sound': 'default',
          'type': CHAT,
          'id': widget.otherData["chatId"],
          'myData': json.encode(widget.otherData),
          'otherData': json.encode(widget.myData),
          'order_number': ""
        },
        'to': "$toParams"};
      print("====> notification data ==>>> ${data.toString()}");
      final headers = {
        'content-type': 'application/json',
        'Authorization': 'key=$serverToken'
      };

      final response = await http.post(Uri.parse(postUrl),
          body: json.encode(data),
          encoding: Encoding.getByName('utf-8'),
          headers: headers);

      if (response.statusCode == 200) {
        // on success do
        print("send notification true");
      } else {
        // on failure do
        print("send notification false");

      }
    });
  }
}
