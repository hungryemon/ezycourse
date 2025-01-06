import 'package:ezycourse/features/feeds/data/models/feed_list_request_model.dart';
import 'package:ezycourse/features/feeds/data/models/feed_list_response_model.dart';

import '../repositories/feeds_repository.dart';

class GetFeedListUseCase {
  GetFeedListUseCase({required this.repository});
  final FeedsRepository repository;

  Future<List<FeedResponse>> execute(FeedListRequest request) async {
    return repository.getFeedList(request);
  }
}
