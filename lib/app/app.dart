import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'bindings/initial_binding.dart';
import 'flavors/build_config.dart';
import 'flavors/env_config.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

class EzyCourseApp extends StatefulWidget {
  const EzyCourseApp({
    super.key,
  });

  @override
  State<EzyCourseApp> createState() => _EzyCourseAppState();
}

class _EzyCourseAppState extends State<EzyCourseApp> {
  final EnvConfig _envConfig = BuildConfig.instance.config;
  List<NavigatorObserver> navigatorObserver =[GetObserver()];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(440, 956),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        rebuildFactor: (old, data) => true,
        builder: (context, scrUtilWidget) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: _envConfig.appName,
            defaultTransition: Transition.noTransition,
            getPages: AppPages.routes,
            initialBinding: InitialBinding(),
            initialRoute: AppRoutes.splash,
            enableLog: true,
            logWriterCallback: (String text, {bool isError = false}) {
              if (BuildConfig.instance.config.shouldCollectLog) {
                debugPrint("GetxLog: $text");
              }
            },
            builder: FToastBuilder(),
            smartManagement: SmartManagement.keepFactory,
            navigatorObservers: navigatorObserver,
          );
        });
  }
}
