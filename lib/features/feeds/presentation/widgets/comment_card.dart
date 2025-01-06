import 'package:ezycourse/app/helpers/constants/asset_constants.dart';
import 'package:ezycourse/app/helpers/constants/color_constants.dart';
import 'package:ezycourse/features/feeds/data/models/comment_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/widgets/misc/custom_network_image.dart';
import 'reply_card.dart';

class CommentCard extends StatelessWidget {
  const CommentCard(
      {super.key, required this.comment, required this.replyOnTap});

  final CommentResponse comment;
  final Function(CommentResponse comment) replyOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            ClipOval(
              child: CustomNetworkImage(
                imageUrl: comment.user?.profilePic ?? '',
                fit: BoxFit.cover,
                height: 54,
                width: 54,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Obx(() {
              if (comment.replies.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(comment.replies.length, (i) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 1,
                            height: 74,
                            color: ColorConstants.grayLight,
                          ),
                          Container(
                            height: 1,
                            width: 20,
                            color: ColorConstants.grayLight,
                          )
                        ],
                      );
                    }),
                  ),
                );
              } else {
                return Container();
              }
            })
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ColorConstants.white60,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comment.user?.fullName ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: ColorConstants.black,
                                    fontWeight: FontWeight.w600),
                          ),
                          Text(
                            comment.commentTxt ?? '',
                            softWrap: true,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: ColorConstants.grayLight2,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Icon(
                      Icons.more_horiz_outlined,
                      color: ColorConstants.black60,
                      size: 22.24,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const SizedBox(width: 16),
                  const Text(
                    "Like",
                    style: TextStyle(color: ColorConstants.indigo60),
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                      onTap: () {
                        replyOnTap(comment);
                      },
                      child: const Text("Reply")),
                  const SizedBox(width: 8),
                  const Spacer(),
                  Text(
                    "${comment.likeCount}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(AssetConstants.likeMini)
                ],
              ),
              const SizedBox(width: 12),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Obx(() {
                  comment.replies;
                  return ListView.separated(
                    itemCount: comment.replies.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ReplyCard(data: comment.replies[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 12,
                      );
                    },
                  );
                }),
              )
            ],
          ),
        )
      ],
    );
  }
}
