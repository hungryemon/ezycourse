// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? preferences;

class SharedPrefUtil {
  static final String _KEY_BEARER_TOKEN = "BearerToken";
 

  static Future<void> setBearerToken(String value) async {
    debugPrint("TOKEN ${preferences?.setString(_KEY_BEARER_TOKEN, value)}");
    await preferences?.setString(_KEY_BEARER_TOKEN, value);
  }

  static String getBearerToken() {
    return preferences?.getString(_KEY_BEARER_TOKEN) ?? "";
  }

  static Future<void> clear() async {
    await preferences?.clear();
  }
}
