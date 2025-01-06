import 'package:get/get.dart';

import '../../../../app/base/base_remote_source.dart';
import '../../data/datasources/feeds_remote_data_source.dart';
import '../../data/models/base_response_model.dart';
import '../../data/models/comment_response_model.dart';
import '../../data/models/create_comment_request_model.dart';
import '../../data/models/create_reply_request_model.dart';
import '../../data/models/feed_request_model.dart';
import '../../data/models/feed_response_model.dart';
import '../../data/models/reaction_request_model.dart';
import '../../data/models/reaction_response_model.dart';
import '../../data/models/reply_response_model.dart';

abstract class FeedsRepository {
  Future<List<FeedResponse>> getFeedList(FeedRequest request);
  Future<ReactionResponse> submitReaction(ReactionRequest req);
  Future<List<CommentResponse>> getCommentList(int id);
  Future<List<ReplyResponse>> getReplyList(int id);
  Future<BaseResponse> createComment(CreateCommentRequest req);
  Future<BaseResponse> createReply(CreateReplyRequest req);
}

class FeedsRepositoryImpl extends BaseRemoteSource implements FeedsRepository {
  final FeedsRemoteDataSource _remoteSource =
      Get.find(tag: (FeedsRemoteDataSource).toString());

  @override
  Future<List<FeedResponse>> getFeedList(FeedRequest request) {
    return _remoteSource.getFeedList(request);
  }

  @override
  Future<BaseResponse> createComment(req) {
    return _remoteSource.createComment(req);
  }

  @override
  Future<BaseResponse> createReply(req) {
    return _remoteSource.createReply(req);
  }

  @override
  Future<List<CommentResponse>> getCommentList(int id) {
    return _remoteSource.getCommentList(id);
  }

  @override
  Future<List<ReplyResponse>> getReplyList(int id) {
    return _remoteSource.getReplyList(id);
  }

  @override
  Future<ReactionResponse> submitReaction(ReactionRequest req) {
    return _remoteSource.submitReaction(req);
  }
}
