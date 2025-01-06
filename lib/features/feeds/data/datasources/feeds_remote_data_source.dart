import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:ezycourse/features/feeds/data/models/base_response_model.dart';
import 'package:ezycourse/features/feeds/data/models/create_comment_request_model.dart';
import 'package:ezycourse/features/feeds/data/models/create_reply_request_model.dart';
import 'package:ezycourse/features/feeds/data/models/feed_request_model.dart';
import 'package:ezycourse/features/feeds/data/models/feed_response_model.dart';
import 'package:ezycourse/features/feeds/data/models/reply_response_model.dart';

import '../../../../app/base/base_remote_source.dart';
import '../../../../app/helpers/constants/api_constants.dart';
import '../../../../core/network/dio_provider.dart';
import '../models/comment_response_model.dart';
import '../models/react_request_model.dart';

abstract class FeedsRemoteDataSource {
  Future<List<FeedResponse>> getFeedList(FeedRequest request);
  Future<BaseResponse> submitReaction(ReactRequest req);
  Future<List<CommentResponse>> getCommentList(int id);
  Future<List<ReplyResponse>> getReplyList(int id);
  Future<BaseResponse> createComment(CreateCommentRequest req);
  Future<BaseResponse> createReply(CreateReplyRequest req);
}

class FeedsRemoteDataSourceImpl extends BaseRemoteSource
    implements FeedsRemoteDataSource {
  @override
  Future<List<FeedResponse>> getFeedList(FeedRequest request) {
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

  @override
  Future<List<CommentResponse>> getCommentList(int id) {
    var endpoint =
        "${DioProvider.baseUrlSecondary}${ApiList.getCommentsUrlWithSecondary}$id";
    var dioCall = dioClient.get(
      endpoint,
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseCommentListResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CommentResponse>> _parseCommentListResponse(
      Response<dynamic> response) async {
    List<CommentResponse> commentResponse = await Isolate.run(
      () => List<CommentResponse>.from(
          response.data.map((x) => CommentResponse.fromJson(x))),
    );
    return commentResponse;
  }

  @override
  Future<List<ReplyResponse>> getReplyList(int id) {
    var endpoint =
        "${DioProvider.baseUrlSecondary}${ApiList.getRepliesUrlWithSecondary}$id";
    var dioCall = dioClient.get(
      endpoint,
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseReplyListResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ReplyResponse>> _parseReplyListResponse(
      Response<dynamic> response) async {
    List<ReplyResponse> replyResponse = await Isolate.run(
      () => List<ReplyResponse>.from(
          response.data.map((x) => ReplyResponse.fromJson(x))),
    );
    return replyResponse;
  }

  @override
  Future<BaseResponse> createReply(CreateReplyRequest request) {
    var endpoint =
        "${DioProvider.baseUrlSecondary}${ApiList.createCommentsUrlWithSecondary}";
    var dioCall = dioClient.post(
      endpoint,
      data: request.toFormData(),
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseBaseResponseResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseResponse> submitReaction(ReactRequest request) {
    var endpoint =
        "${DioProvider.baseUrlSecondary}${ApiList.createLikeUrlWithSecondary}";
    var dioCall = dioClient.post(
      endpoint,
      data: request.toFormData(),
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseBaseResponseResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseResponse> createComment(CreateCommentRequest request) {
    var endpoint =
        "${DioProvider.baseUrlSecondary}${ApiList.createCommentsUrlWithSecondary}";
    var dioCall = dioClient.post(
      endpoint,
      data: request.toFormData(),
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseBaseResponseResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<BaseResponse> _parseBaseResponseResponse(
      Response<dynamic> response) async {
    BaseResponse baseResponse =
        await Isolate.run(() => BaseResponse.fromJson(response.data));
    return baseResponse;
  }
}
