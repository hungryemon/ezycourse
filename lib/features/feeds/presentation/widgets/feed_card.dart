import 'package:ezycourse/app/helpers/constants/asset_constants.dart';
import 'package:ezycourse/app/helpers/constants/color_constants.dart';
import 'package:ezycourse/app/widgets/misc/custom_html_widget.dart';
import 'package:ezycourse/features/feeds/data/models/feed_response_model.dart';
import 'package:ezycourse/features/feeds/data/models/reaction_request_model.dart';
import 'package:ezycourse/features/feeds/data/models/reaction_response_model.dart';
import 'package:ezycourse/features/feeds/domain/usecases/submit_reaction_usecase.dart';
import 'package:ezycourse/features/feeds/presentation/controllers/comments_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../app/helpers/constants/app_constants.dart';
import '../../../../app/helpers/utils/app_util.dart';
import '../../../../app/widgets/misc/custom_network_image.dart';
import 'comments_bottom_sheet.dart';

class FeedCard extends StatefulWidget {
  const FeedCard({
    super.key,
    required this.data,
  });

  final FeedResponse data;

  @override
  State<FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<FeedCard> {
  RxBool isUserReacted = false.obs;
  RxInt reactionCount = 0.obs;
  RxList<String> likeTypeList = RxList.empty();

  @override
  void initState() {
    isUserReacted(widget.data.like != null);
    reactionCount(widget.data.likeCount ?? 0);
    likeTypeList(widget.data.likeType
            ?.map((item) => item.reactionType as String)
            .toList() ??
        []);
    super.initState();
  }

  createOrDeleteReaction(String val, String prevVal) async {
    try {
      final SubmitReactionUseCase submitReactionUseCase =
          Get.find(tag: (SubmitReactionUseCase).toString());
      ReactionRequest req = ReactionRequest(
        feedId: widget.data.id ?? 0,
        action: val.isEmpty ? 'Delete' : 'Create',
        reactionType:
            val.isNotEmpty ? val.toUpperCase() : prevVal.toUpperCase(),
      );

      ReactionResponse response = await submitReactionUseCase.execute(req);
      reactionCount(response.totalReactions ?? reactionCount.value);
      likeTypeList(response.likeType
              ?.map((item) => item.reactionType as String)
              .toList() ??
          []);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _handleOnReactTap({
    required String newVal,
    required String prevVal,
  }) {
    if (newVal.isEmpty) {
      isUserReacted(false);
      if (prevVal.isNotEmpty) {
        reactionCount(reactionCount.value - 1);
      }
    } else {
      isUserReacted(true);
      if (prevVal.isEmpty) {
        reactionCount(reactionCount.value + 1);
      }
    }
    createOrDeleteReaction(newVal, prevVal);
  }

  _handleCommentTap() {
    Get.lazyReplace(() => CommentsController(
          reactionCount: reactionCount.value,
          isUserReacted: isUserReacted.value,
          likeType: likeTypeList,
          feedId: widget.data.id ?? 0,
          feedUserId: widget.data.userId ?? 0,
        ));
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return CommentsBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTopSection(context),
        const SizedBox(height: 9),
        const Divider(),
        const SizedBox(height: 9),
        _buildDescriptionSection(context),
        const SizedBox(height: 16),
        if (widget.data.files != null &&
            widget.data.files!.isNotEmpty &&
            widget.data.fileType == "photos")
          _buildImageSection(),
        const SizedBox(height: 12),
        _buildReactionAndCommentCountSection(context),
        const SizedBox(height: 16),
        _buildReactAndCommentButtonSection(context),
        const SizedBox(
          height: 32,
        )
      ],
    );
  }

  Row _buildTopSection(BuildContext context) {
    return Row(
      children: [
        CustomNetworkImage(
          imageUrl: widget.data.pic ?? '',
          height: 34,
          width: 34,
          borderRadius: 20,
        ),
        const SizedBox(width: 8.31),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${widget.data.name}",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorConstants.black110,
                      fontWeight: FontWeight.bold)),
              Text(AppUtil.displayTimeAgoFromTimestamp(widget.data.createdAt),
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: ColorConstants.grayLight2)),
            ],
          ),
        ),
        const Icon(
          Icons.more_vert_outlined,
          size: 31.76,
          color: ColorConstants.black60,
        ),
      ],
    );
  }

  _buildDescriptionSection(context) {
    return widget.data.isBackground == 1
        ? Container(
            constraints:
                const BoxConstraints(minHeight: 160, minWidth: double.infinity),
            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: AppUtil.getGradiant(widget.data.bgColor ?? ""),
            ),
            child: Center(
              child: CustomHtmlWidget(
                htmlString: widget.data.feedTxt ?? '',
                textStyle: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: ColorConstants.black),
              ),
            ),
          )
        : CustomHtmlWidget(
            htmlString: widget.data.feedTxt ?? '',
            textStyle: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: ColorConstants.black),
          );
  }

  CustomNetworkImage _buildImageSection() {
    return CustomNetworkImage(
      width: double.infinity,
      borderRadius: 3.2,
      imageUrl: widget.data.files?.first.fileLoc ?? "",
      fit: BoxFit.cover,
    );
  }

  _buildReactionAndCommentCountSection(context) {
    return Obx(() {
      likeTypeList;
      return Row(
        children: [
          if (likeTypeList.isNotEmpty)
            Row(
              textDirection: TextDirection.rtl,
              children: likeTypeList
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
          if (likeTypeList.isNotEmpty) const SizedBox(width: 12),
          Expanded(
            child: Text(
                isUserReacted.value && reactionCount > 1
                    ? 'You and ${reactionCount.value} others'
                    : isUserReacted.value
                        ? 'You reacted'
                        : '${reactionCount.value} Reacted',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorConstants.grayDark2,
                    fontWeight: FontWeight.w700)),
          ),
          InkWell(
            onTap: _handleCommentTap,
            child: Row(
              children: [
                SvgPicture.asset(AssetConstants.comment),
                const SizedBox(width: 8),
                Text(
                  '${widget.data.commentCount} Comments',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorConstants.grayDark2,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          )
        ],
      );
    });
  }

  Row _buildReactAndCommentButtonSection(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomReactionWidget(
            onReactTap: (newVal, prevVal) {
              _handleOnReactTap(newVal: newVal, prevVal: prevVal);
            },
            data: widget.data),
        Container(
          width: 0.64,
          height: 15.35,
          color: ColorConstants.grayLight,
        ),
        InkWell(
          onTap: _handleCommentTap,
          child: Row(
            children: [
              Image.asset(
                AssetConstants.commentsFill,
                height: 20,
                width: 20,
              ),
              const SizedBox(width: 4),
              Text(
                'Comment',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ColorConstants.black85,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CustomReactionWidget extends StatefulWidget {
  const CustomReactionWidget({
    super.key,
    required this.onReactTap,
    required this.data,
  });

  final Function(String newVal, String prevVal) onReactTap;
  final FeedResponse data;

  @override
  State<CustomReactionWidget> createState() => _CustomReactionWidgetState();
}

class _CustomReactionWidgetState extends State<CustomReactionWidget> {
  String _reaction = '';
  @override
  void initState() {
    super.initState();
    _reaction = widget.data.like?.reactionType?.toUpperCase() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return ReactionButton(
      toggle: false,
      direction: ReactionsBoxAlignment.ltr,
      onReactionChanged: (Reaction<String>? reaction) {
        bool isSameReactionPressed =
            reaction?.value != null && _reaction == reaction!.value;
        widget.onReactTap(
            isSameReactionPressed ? '' : reaction?.value ?? '', _reaction);
        if (isSameReactionPressed) {
          _reaction = '';
        } else {
          _reaction = reaction?.value?.toUpperCase() ?? '';
        }

        setState(() {});
      },
      reactions: AppConstant.reactionList,
      boxColor: Colors.white,
      boxRadius: 30,
      itemsSpacing: 16,
      itemSize: const Size(40, 40),
      boxPadding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Image.asset(
            _reaction.isNotEmpty
                ? AppUtil.getReactionImage(
                    reactionType: _reaction, secondLike: false)
                : AssetConstants.likeMiniFill,
            height: 20,
            width: 20,
            color: _reaction.isEmpty
                ? ColorConstants.grayDark
                : _reaction == 'LIKE'
                    ? ColorConstants.indigo60
                    : null,
          ),
          const SizedBox(width: 8),
          Text(
              _reaction.isNotEmpty
                  ? AppUtil.capitalizeFirst(_reaction)
                  : 'Like',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _reaction.isEmpty
                        ? ColorConstants.grayDark
                        : _reaction == 'LIKE'
                            ? ColorConstants.indigo60
                            : ColorConstants.grayDark,
                    fontWeight: FontWeight.w600,
                  ))
        ],
      ),
    );
  }
}
