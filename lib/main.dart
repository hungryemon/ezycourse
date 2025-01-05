import 'dart:async';

import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/flavors/build_config.dart';
import 'app/flavors/env_config.dart';
import 'app/flavors/environment.dart';
import 'app/helpers/constants/api_constants.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
   WidgetsFlutterBinding.ensureInitialized();

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
