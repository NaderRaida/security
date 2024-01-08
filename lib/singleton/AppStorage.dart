import 'dart:convert';
import 'package:app/models/LoginModel.dart';
import 'package:get_storage/get_storage.dart';

class AppStorage {
  final storage = GetStorage();

  static const LANGUAGE_CODE = "language_code";
  static const COUNTRY_CODE = "country_code";
  static const USER_TYPE = "user_type";
  static const USER = "user";
  static const TOKEN = "token";


  clear() {
    storage.remove('token');
    storage.remove('language_code');
    storage.remove('country_code');
    storage.remove('user_type');
    storage.remove('user');
  }

  Future<void> setLanguageCode(String code) async {
    
    return await storage.write(LANGUAGE_CODE, code);
  }

  String? getLanguageCode() {
    return storage.read(LANGUAGE_CODE);
  }
  Future<void> setCountryCode(String code) async {
    return await storage.write(COUNTRY_CODE, code);
  }

  String getCountryCode() {
    return storage.read(COUNTRY_CODE);
  }

  String? getUserType() {
    return storage.read(USER_TYPE);
  }
  Future<void> setUserType(String type) async {
    return await storage.write(USER_TYPE, type);
  }

  Future<void> setLogin(LoginModel? loginModel) async {
    String user = jsonEncode(loginModel);
    return await storage.write(USER, user);
  }

  LoginModel? getLogin() {
    if(storage.read(USER) == null){
      return null;
    }
    var map =  jsonDecode(storage.read(USER));
    return LoginModel.fromJson(map);
  }

  void setUserToken({required String token}) async {

    return await storage.write(TOKEN, token);
  }

  void clearUserToken() async {

    return await storage.write(TOKEN, '');
  }

  String? getUserToken() {

    return storage.read(TOKEN);
  }
}
