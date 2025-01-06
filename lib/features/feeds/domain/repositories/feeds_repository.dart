import 'package:get/get.dart';

import '../../../../app/base/base_remote_source.dart';
import '../../data/datasources/feeds_remote_data_source.dart';
import '../../data/models/feed_list_request_model.dart';
import '../../data/models/feed_list_response_model.dart';

abstract class FeedsRepository {
  Future<List<FeedResponse>> getFeedList(FeedListRequest request);
}

class FeedsRepositoryImpl extends BaseRemoteSource implements FeedsRepository {
  final FeedsRemoteDataSource _remoteSource =
      Get.find(tag: (FeedsRemoteDataSource).toString());

  @override
  Future<List<FeedResponse>> getFeedList(FeedListRequest request) {
    return _remoteSource.getFeedList(request);
  }
}
