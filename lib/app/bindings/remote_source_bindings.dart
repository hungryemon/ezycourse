import 'package:get/get.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/feeds/data/datasources/feeds_remote_data_source.dart';
import '../../features/post/data/datasource/post_remote_data_source.dart';

class RemoteSourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(),
        tag: (AuthRemoteDataSource).toString(), fenix: true);
     Get.lazyPut<FeedsRemoteDataSource>(() => FeedsRemoteDataSourceImpl(),
        tag: (FeedsRemoteDataSource).toString(), fenix: true);
    Get.lazyPut<PostRemoteDataSource>(() => PostRemoteDataSourceImpl(),
        tag: (PostRemoteDataSource).toString(), fenix: true);
  }
}
