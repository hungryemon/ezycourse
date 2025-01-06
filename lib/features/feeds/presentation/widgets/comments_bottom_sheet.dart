
import 'package:ezycourse/app/helpers/constants/asset_constants.dart';
import 'package:ezycourse/app/widgets/toast/ezycourse_toast.dart';
import 'package:ezycourse/features/feeds/data/models/create_reply_request_model.dart';
import 'package:ezycourse/features/feeds/presentation/controllers/comments_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../app/helpers/constants/color_constants.dart';
import '../../../../app/helpers/utils/app_util.dart';
import '../../data/models/comment_response_model.dart';
import '../../data/models/create_comment_request_model.dart';
import 'comment_card.dart';

class CommentsBottomSheet extends GetWidget<CommentsController> {
  const CommentsBottomSheet({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .84,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        child: Scaffold(
          backgroundColor: ColorConstants.white,
          body: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildLikeAndReactionCount(context),
                const SizedBox(height: 32),
                Expanded(
                  child:  _buildCommentListSection(),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFFF0F2F5),
                  ),
                  child: _buildTextFieldSection(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Obx _buildTextFieldSection() {
    return Obx(() {
      controller.selectedComment.value;
      return Column(
        children: [
          if (controller.selectedComment.value.id != null)
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text("Reply to "),
                      Obx(() {
                        return Text(
                          controller.selectedComment.value.user?.fullName ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                      const SizedBox(width: 16),
                      InkWell(
                          onTap: () {
                            controller.selectedComment(CommentResponse());
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: ColorConstants.redAccent),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      ClipOval(
                        child: Image.asset(
                          AssetConstants.userPlaceholder,
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: TextField(
                          focusNode: controller.commentTextFocus,
                          controller: controller.commentTextController,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: "Write a comment",
                            hintStyle: TextStyle(
                              color: Color(0xFF98A2B3),
                              fontFamily: 'Figtree',
                              fontSize: 16,
                            ),
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (controller.commentTextController.text.isEmpty) {
                    EzyCourseToast.error(msg: "Please write something");
                    return;
                  }

                  if (controller.selectedComment.value.id == null) {
                    controller.createComment(
                      CreateCommentRequest(
                          feedId: controller.feedId,
                          feedUserId: controller.feedUserId,
                          commentText:
                              controller.commentTextController.text,
                          commentSource: "COMMUNITY"),
                    );

                    AppUtil.hideKeyboard();
                    controller.commentTextController.clear();
                  } else {
                    controller.createReply(
                      CreateReplyRequest(
                        feedId: controller.feedId,
                        feedUserId: controller.feedUserId,
                        commentTxt:
                            controller.commentTextController.text,
                        commentSource: "COMMUNITY",
                        parrentId:
                            controller.selectedComment.value.id ?? 0,
                      ),
                    );

                    AppUtil.hideKeyboard();
                    controller.commentTextController.clear();
                  }
                },
                child: Container(
                  width: 60,
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Color(0xFF004852),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(child: SvgPicture.asset(AssetConstants.send)),
                ),
              )
            ],
          ),
        ],
      );
    });
  }

  Obx _buildCommentListSection() {
    return Obx(() {
      return controller.isCommentListLoading.value
                  ? Center(child: SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(
            color: ColorConstants.deepGreen100,
          )),) : ListView.separated(
        itemCount: controller.commentResponseList.length,
        itemBuilder: (context, index) {
          return CommentCard(
            comment: controller.commentResponseList[index],
            replyOnTap: (CommentResponse comment) {
              controller.selectedComment(comment);
              controller.commentTextFocus.requestFocus();
            },
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 16,
          );
        },
      );
    });
  }

  Row _buildLikeAndReactionCount(BuildContext context) {
    return Row(
      children: [
        if (controller.likeType.isNotEmpty)
          Row(
            textDirection: TextDirection.rtl,
            children: controller.likeType
                .map(
                  (el) => Align(
                    widthFactor: .7,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Image.asset(
                        AppUtil.getReactionImage(
                            reactionType: el, secondLike: true),
                        height: 16,
                        width: 16,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        if (controller.likeType.isNotEmpty) const SizedBox(width: 12),
        Expanded(
          child: Text(
            controller.isUserReacted && controller.reactionCount > 1
                ? 'You and ${controller.reactionCount} others'
                : controller.isUserReacted
                    ? 'You reacted'
                    : '${controller.reactionCount} Reacted',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorConstants.grayDark2, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
