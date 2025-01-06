import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:ezycourse/features/post/data/model/create_post_request_model.dart';
import 'package:ezycourse/features/post/data/model/create_post_response_model.dart';

import '../../../../app/base/base_remote_source.dart';
import '../../../../app/helpers/constants/api_constants.dart';
import '../../../../core/network/dio_provider.dart';

abstract class PostRemoteDataSource {
  Future<CreatePostResponse> createPost(CreatePostRequest request);
}

class PostRemoteDataSourceImpl extends BaseRemoteSource
    implements PostRemoteDataSource {
  @override
  Future<CreatePostResponse> createPost(CreatePostRequest request) async {
    var endpoint =
        "${DioProvider.baseUrlSecondary}${ApiList.createPostUrlWithSecondary}";
    var dioCall = dioClient.post(
      endpoint,
      data: request.toFormData(),
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseCreatePostResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<CreatePostResponse> _parseCreatePostResponse(
      Response<dynamic> response) async {
   CreatePostResponse createPostResponse =
        await Isolate.run(() => CreatePostResponse.fromJson(response.data));
    return createPostResponse;
  }
}
