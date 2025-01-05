import 'package:ezycourse/features/auth/domain/usecases/login_usecase.dart';
import 'package:ezycourse/features/feeds/domain/usecases/feeds_usecase.dart';
import 'package:get/get.dart';

import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/feeds/domain/repositories/feeds_repository.dart';

class UseCasesBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginUseCase>(() => LoginUseCase(
      repository: Get.find(tag: (AuthRepository).toString()),
    ), tag: (LoginUseCase).toString(), fenix: true);
    Get.lazyPut<LogoutUseCase>(() => LogoutUseCase(
       repository: Get.find(tag: (AuthRepository).toString()),
    ), tag: (LogoutUseCase).toString(), fenix: true);
    Get.lazyPut<GetFeedUseCase>(() => GetFeedUseCase(
       repository: Get.find(tag: (FeedsRepository).toString()),
    ), tag: (GetFeedUseCase).toString(), fenix: true);
  }
}
