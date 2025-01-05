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

    EnvConfig devConfig = EnvConfig(
      appName: "EzyCourse Dev",
      baseUrlPrimary: ApiConstants.baseUrlDevPrimary,
      baseUrlSecondary: ApiConstants.baseUrlDevSecondary,
      shouldCollectLog: true,
    );

    BuildConfig.instantiate(
      envType: Environment.DEVELOPMENT,
      envConfig: devConfig,
    );
    runApp(
      EzyCourseApp(),
    );
  }, (error, stack) async {});
}
