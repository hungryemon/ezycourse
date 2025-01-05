import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'app/flavors/build_config.dart';
import 'app/flavors/env_config.dart';
import 'app/flavors/environment.dart';
import 'app/helpers/constants/api_constants.dart';
import 'app/helpers/utils/shared_pref_util.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
   WidgetsFlutterBinding.ensureInitialized();
   preferences = await SharedPreferences.getInstance();

    EnvConfig prodConfig = EnvConfig(
      appName: "EzyCourse",
      baseUrlPrimary: ApiConstants.baseUrlProdPrimary,
      baseUrlSecondary: ApiConstants.baseUrlProdSecondary,
      shouldCollectLog: false,
    );

    BuildConfig.instantiate(
      envType: Environment.PRODUCTION,
      envConfig: prodConfig,
    );
    runApp(
      EzyCourseApp(),
    );
  }, (error, stack) async {});
}
