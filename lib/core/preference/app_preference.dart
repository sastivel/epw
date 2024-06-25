// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/common_imports.dart';

import '../../api/interface/login/login_response.dart';
import 'base_preference.dart';

class AppPreferences implements BasePreference {
  //------------------------- USER DETAILS -------------------------
  static const String PREF_USER_LOGGED_IN = "PREF_USER_LOGGED_IN";
  static const String PREF_USER_ID = "PREF_USER_ID";
  static const String PREF_USER = "PREF_USER";
    static const String PREF_USER_LANGUAGE = "PREF_USER_LANGUAGE";

  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  @override
  String getUserId() {
    return _sharedPreferences.getString(PREF_USER_ID) ?? "";
  }

  @override
  Future<LoginResponseModel?> getUser() async {
    String? value;
    value = _sharedPreferences.getString(PREF_USER);
    if (value == null) {
      return null;
    } else {
      final Map<String, dynamic> map = await _parseJson(value);
      return LoginResponseModel.fromJson(map);
    }
  }

  @override
  Future setUser(LoginResponseModel loginResponse) async {
    String userString = "";
    userString = jsonEncode(loginResponse.toJson());
    await _sharedPreferences.setString("PREF_USER", userString);
  }

  @override
  void setUserId(String userId) {
    _sharedPreferences.setString(PREF_USER_ID, userId);
  }

  @override
  bool isUserLoggedIn() {
    return _sharedPreferences.getBool(PREF_USER_LOGGED_IN) ?? false;
  }

  @override
  void setUserLoggedIn(bool value) {
    _sharedPreferences.setBool(PREF_USER_LOGGED_IN, value);
  }


    @override
  void saveLanguageCode(bool value) {
    _sharedPreferences.setBool(PREF_USER_LANGUAGE, value);
  }

  
  @override
  bool getLanguageCode() {
    return _sharedPreferences.getBool(PREF_USER_LANGUAGE) ?? false;
  }


  @override
 

  static Future<Map<String, dynamic>> _parseJson(String text) {
    return compute(_parseAndDecode, text);
  }

  static Map<String, dynamic> _parseAndDecode(String response) {
    return jsonDecode(response) as Map<String, dynamic>;
  }
  
  @override
  Future<void> clearStorage() async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.remove(PREF_USER_ID);
      prefs.remove(PREF_USER);
       prefs.remove(PREF_USER_LOGGED_IN);
        prefs.remove(PREF_USER_LANGUAGE);
  }

  
}
