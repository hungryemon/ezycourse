import 'package:get/get.dart';

import '../../../../app/base/base_remote_source.dart';
import '../../data/datasource/post_remote_data_source.dart';
import '../../data/model/create_post_request_model.dart';
import '../../data/model/create_post_response_model.dart';

abstract class PostRepository {
   Future<CreatePostResponse> createPost(CreatePostRequest request);
}

class PostRepositoryImpl extends BaseRemoteSource implements PostRepository {
  final PostRemoteDataSource _remoteSource =
      Get.find(tag: (PostRemoteDataSource).toString());

  @override
  Future<CreatePostResponse> createPost(CreatePostRequest request) {
    return _remoteSource.createPost(request);
  }
}
