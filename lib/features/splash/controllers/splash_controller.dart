import 'dart:async';

import 'package:ezycourse/app/routes/app_routes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import '../../../app/base/base_controller.dart';
import '../../../app/helpers/utils/shared_pref_util.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    FlutterNativeSplash.remove();
    getInitialData();

    super.onInit();
  }

  getInitialData() async {
    await startTime();
  }

  Future<Timer> startTime() async {
    var duration = const Duration(seconds: 2);
    var timer = Timer(duration, () {
      getToInitialNavigation();
    });

    return timer;
  }

  getToInitialNavigation() async {
    if (SharedPrefUtil.getBearerToken().isNotEmpty) {
      Get.offAndToNamed(AppRoutes.feeds);
    } else {
      Get.offAndToNamed(AppRoutes.login);
    }
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
