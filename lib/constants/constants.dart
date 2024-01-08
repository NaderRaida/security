import 'package:app/main.dart' as main;
import 'package:flutter/material.dart';

const String HOST_URL = "https://secsysolutions.herokuapp.com/en/api/";

const TEST_ENV = true;

///Fonts
const String PRIMARY_FONT_EXTRA_LIGHT = "Cairo ExtraLight";
const String PRIMARY_FONT_LIGHT = "Cairo Light";
const String PRIMARY_FONT_REGULAR = "Cairo Regular";
const String PRIMARY_FONT_MEDIUM = "Cairo Medium";
const String PRIMARY_FONT_SEMI_BOLD = "Cairo SemiBold";
const String PRIMARY_FONT_BOLD = "Cairo Bold";
const String PRIMARY_FONT_EXTRA_BOLD = "Cairo ExtraBold";
const String PRIMARY_FONT_BLACK = "Cairo Black";

///chatting
const String TEXT = "text";
const CHAT_ROOT_PARENT = TEST_ENV ? "TestChatRooms" : "ChatRooms";


///assets
const String ASSETS_IMAGES = "assets/images/";
const String ASSETS_ICONS = "assets/icons/";

///main context from navigation Key
BuildContext? mainContext = main.navigatorKey.currentContext;

///user types
const String CLIENT_USER = "client";
const String SUPERVISOR_USER = "supervisor";

///Dialog
const int GENERAL_DIALOG = 0;
const int DELETE_DIALOG = 1;
const int UN_AUTH_DIALOG = 2;
const int LOGOUT_DIALOG = 3;
const int DECISION_DIALOG = 4;
const int LANGUAGE_DIALOG = 5;

///Images
const String SVG = "svg";
const String PNG = "png";

///TextField
const int FULL_NAME = 0;
const int MOBILE = 1;
const int PASSWORD = 2;
const int CONFIRM_PASSWORD = 9;
const int CODE = 3;
const int SEARCH = 4;
const int EMAIL = 5;
const int MESSAGE = 6;
const int PROMO_CODE = 7;
const int POINTS = 8;
const int ADDRESS = 10;

///REG-EXP
RegExp emojiReg = RegExp(r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');

///notifications
const String CHAT = "chat";
