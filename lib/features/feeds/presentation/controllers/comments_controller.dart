import 'package:ezycourse/app/base/base_controller.dart';
import 'package:ezycourse/features/feeds/data/models/base_response_model.dart';
import 'package:ezycourse/features/feeds/data/models/comment_response_model.dart';
import 'package:ezycourse/features/feeds/data/models/create_comment_request_model.dart';
import 'package:ezycourse/features/feeds/domain/usecases/create_comment_usecase.dart';
import 'package:ezycourse/features/feeds/domain/usecases/get_comment_list_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../data/models/create_reply_request_model.dart';
import '../../data/models/reply_response_model.dart';
import '../../domain/usecases/create_reply_usecase.dart';
import '../../domain/usecases/get_reply_list_usecase.dart';

class CommentsController extends BaseController {
  CommentsController({
    required this.reactionCount,
    required this.isUserReacted,
    required this.likeType,
    required this.feedId,
    required this.feedUserId,
  });

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  initialize() {
    getCommentList(feedId: feedId, showLoader: true);
  }

  final GetCommentListUseCase _getCommentListUseCase =
      Get.find(tag: (GetCommentListUseCase).toString());
  final GetReplyListUseCase _getReplyListUseCase =
      Get.find(tag: (GetReplyListUseCase).toString());
  final CreateCommentUseCase _createCommentUseCase =
      Get.find(tag: (CreateCommentUseCase).toString());
  final CreateReplyUseCase _createReplyUseCase =
      Get.find(tag: (CreateReplyUseCase).toString());

  final bool isUserReacted;
  final List<String> likeType;
  final int reactionCount;
  final int feedId;
  final int feedUserId;
  final TextEditingController commentTextController = TextEditingController();
  final FocusNode commentTextFocus = FocusNode();

  final Rx<CommentResponse> selectedComment = CommentResponse().obs;

  final RxList<CommentResponse> _commentResponseList = RxList.empty();
  List<CommentResponse> get commentResponseList => _commentResponseList();
  final RxBool isCommentListLoading = false.obs;

  final RxList<ReplyResponse> _replyResponseList = RxList.empty();
  List<ReplyResponse> get replyResponseList => _replyResponseList();
  final RxBool isReplyListLoading = false.obs;

  void getCommentList({required int feedId, required bool showLoader}) {
    if (isCommentListLoading.value) return;
    isCommentListLoading(showLoader);
    final getCommentListService = _getCommentListUseCase.call(feedId);
    callDataService(
      getCommentListService,
      hideLoader: true,
      onComplete: () {
        isCommentListLoading(false);
      },
      onSuccess: _handleCommentListSuccess,
    );
  }

  _handleCommentListSuccess(List<CommentResponse> res) async {
    _commentResponseList(res);
    _commentResponseList.map((e) {
      getReplyList(commentId: e.id ?? 0, showLoader: false);
    }).toList();
  }

  void getReplyList({
    required int commentId,
    required bool showLoader,
  }) {
    if (isReplyListLoading.value) return;
    isReplyListLoading(showLoader);
    final getReplyListService = _getReplyListUseCase.call(commentId);
    callDataService(
      getReplyListService,
      hideLoader: false,
      onComplete: () {
        isReplyListLoading(false);
      },
      onSuccess: (res) {
        _handleReplyListSuccess(res, commentId);
      },
    );
  }

  _handleReplyListSuccess(List<ReplyResponse> res, commentId) async {
    _commentResponseList
        .firstWhere((e) => e.id == commentId)
        .replies
        .addAll(res);
  }

  void createComment(CreateCommentRequest req) {
    final createCommentService = _createCommentUseCase.execute(req);
    callDataService(
      createCommentService,
      hideLoader: true,
      onComplete: () {},
      onSuccess: _handleCreateCommentSuccess,
    );
  }

  _handleCreateCommentSuccess(BaseResponse res) async {
    getCommentList(feedId: feedId, showLoader: false);
  }

  void createReply(CreateReplyRequest req) {
    final createReplyService = _createReplyUseCase.execute(req);
    callDataService(
      createReplyService,
      hideLoader: true,
      onComplete: () {},
      onSuccess: _handleCreateReplySuccess,
    );
  }

  _handleCreateReplySuccess(BaseResponse res) async {
    getCommentList(feedId: feedId, showLoader: false);
  }

  @override
  void dispose() {
    commentTextController.dispose();
    commentTextFocus.dispose();
    super.dispose();
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
