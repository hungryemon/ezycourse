import 'package:ezycourse/features/auth/domain/usecases/login_usecase.dart';
import 'package:ezycourse/features/feeds/domain/usecases/get_feed_list_usecase.dart';
import 'package:ezycourse/features/post/domain/usecases/create_post_usecase.dart';
import 'package:get/get.dart';

import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/feeds/domain/repositories/feeds_repository.dart';
import '../../features/post/domain/repository/post_repository.dart';

class UseCasesBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginUseCase>(
        () => LoginUseCase(
              repository: Get.find(tag: (AuthRepository).toString()),
            ),
        tag: (LoginUseCase).toString(),
        fenix: true);
    Get.lazyPut<LogoutUseCase>(
        () => LogoutUseCase(
              repository: Get.find(tag: (AuthRepository).toString()),
            ),
        tag: (LogoutUseCase).toString(),
        fenix: true);
    Get.lazyPut<GetFeedListUseCase>(
        () => GetFeedListUseCase(
              repository: Get.find(tag: (FeedsRepository).toString()),
            ),
        tag: (GetFeedListUseCase).toString(),
        fenix: true);
     Get.lazyPut<CreatePostUseCase>(
        () => CreatePostUseCase(
              repository: Get.find(tag: (PostRepository).toString()),
            ),
        tag: (CreatePostUseCase).toString(),
        fenix: true);
  }
}
