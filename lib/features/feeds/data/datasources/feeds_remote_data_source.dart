import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:ezycourse/features/feeds/data/models/feed_list_request_model.dart';
import 'package:ezycourse/features/feeds/data/models/feed_list_response_model.dart';

import '../../../../app/base/base_remote_source.dart';
import '../../../../app/helpers/constants/api_constants.dart';
import '../../../../core/network/dio_provider.dart';

abstract class FeedsRemoteDataSource {
  Future<List<FeedResponse>> getFeedList(FeedListRequest request);
}

class FeedsRemoteDataSourceImpl extends BaseRemoteSource
    implements FeedsRemoteDataSource {
  @override
  Future<List<FeedResponse>> getFeedList(FeedListRequest request) {
    var endpoint =
        "${DioProvider.baseUrlSecondary}${ApiList.feedUrlWithSecondary}";
    var dioCall = dioClient.post(
      endpoint,
      data: request.toFormData(),
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseFeedListResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<List<FeedResponse>> _parseFeedListResponse(
      Response<dynamic> response) async {
    List<FeedResponse> feedListResponse = await Isolate.run(
      () => List<FeedResponse>.from(
          response.data.map((x) => FeedResponse.fromJson(x))),
    );
    return feedListResponse;
  }
}
