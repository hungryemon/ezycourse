import 'package:ezycourse/app/routes/app_routes.dart';
import 'package:ezycourse/features/feeds/presentation/bindings/feeds_binding.dart';
import 'package:ezycourse/features/feeds/presentation/views/feeds_view.dart';
import 'package:get/get.dart';

import '../../features/auth/presentation/bindings/login_binding.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/splash/bindings/splash_binding.dart';
import '../../features/splash/views/splash_view.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      binding: SplashBinding(),
      page: () => SplashView(),
    ),
    GetPage(
      name: AppRoutes.login,
      binding: LoginBinding(),
      page: () => LoginView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.feeds,
      binding: FeedsBinding(),
      page: () => FeedsView(),
      transition: Transition.rightToLeft,
    ),
  ];
}
