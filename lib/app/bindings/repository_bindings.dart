import 'package:ezycourse/features/auth/domain/repositories/auth_repository.dart';
import 'package:get/get.dart';

import '../../features/feeds/domain/repositories/feeds_repository.dart';
import '../../features/post/domain/repository/post_repository.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(),
        tag: (AuthRepository).toString(), fenix: true);
     Get.lazyPut<FeedsRepository>(() => FeedsRepositoryImpl(),
        tag: (FeedsRepository).toString(), fenix: true);
    Get.lazyPut<PostRepository>(() => PostRepositoryImpl(),
        tag: (PostRepository).toString(), fenix: true);
  }
}
