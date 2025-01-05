// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? preferences;

class SharedPrefUtil {
  static final String _KEY_BEARER_TOKEN = "BearerToken";
  static final String _KEY_EMAIL = "Email";
  static final String _KEY_PASSWORD = "Password";
  static final String _KEY_IS_REMEMBER_ME = "IsRememberMe";

  static Future<void> setBearerToken(String value) async {
    debugPrint("TOKEN ${preferences?.setString(_KEY_BEARER_TOKEN, value)}");
    await preferences?.setString(_KEY_BEARER_TOKEN, value);
  }

  static String getBearerToken() {
    return preferences?.getString(_KEY_BEARER_TOKEN) ?? "";
  }


  static Future<void> setEmail(String value) async {
    debugPrint("Email ${preferences?.setString(_KEY_EMAIL, value)}");
    await preferences?.setString(_KEY_EMAIL, value);
  }

  static String getEmail() {
    return preferences?.getString(_KEY_EMAIL) ?? "";
  }

   static Future<void> setPassword(String value) async {
    debugPrint("Password ${preferences?.setString(_KEY_PASSWORD, value)}");
    await preferences?.setString(_KEY_PASSWORD, value);
  }

  static String getPassword() {
    return preferences?.getString(_KEY_PASSWORD) ?? "";
  }

   static Future<void> setIsRememberMe(bool value) async {
    debugPrint("Remember Me ${preferences?.setBool(_KEY_IS_REMEMBER_ME, value)}");
    await preferences?.setBool(_KEY_IS_REMEMBER_ME, value);
  }

  static bool getIsRememberMe() {
    return preferences?.getBool(_KEY_EMAIL) ?? false;
  }

  static Future<void> clear() async {
    await preferences?.clear();
  }
}
