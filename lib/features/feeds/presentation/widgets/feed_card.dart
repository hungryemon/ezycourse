import 'package:ezycourse/app/helpers/constants/asset_constants.dart';
import 'package:ezycourse/app/helpers/constants/color_constants.dart';
import 'package:ezycourse/app/widgets/misc/custom_html_widget.dart';
import 'package:ezycourse/features/feeds/data/models/feed_list_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../app/helpers/constants/app_constants.dart';
import '../../../../app/helpers/utils/app_util.dart';
import '../../../../app/widgets/misc/custom_network_image.dart';

class FeedCard extends StatelessWidget {
  const FeedCard(
      {super.key,
      required this.data,
      required this.onReactTap,
      required this.commentsOnTap});

  final FeedResponse data;

  final Function(String text) onReactTap;
  final Function(String text) commentsOnTap;

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
        if (data.files != null &&
            data.files!.isNotEmpty &&
            data.fileType == "photos")
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
          imageUrl: data.pic ?? '',
          height: 34,
          width: 34,
          borderRadius: 20,
        ),
        const SizedBox(width: 8.31),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${data.name}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: ColorConstants.black110, fontWeight: FontWeight.bold)),
              Text(
                  AppUtil.displayTimeAgoFromTimestamp(
                      data.createdAt.toString()),
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
   return data.isBackground == 1
        ? Container(
            constraints:
                const BoxConstraints(minHeight: 160, minWidth: double.infinity),
            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: AppUtil.getGradiant(data.bgColor ?? ""),
            ),
            child: Center(
              child: CustomHtmlWidget(
                htmlString: data.feedTxt ?? '',
                textStyle: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: ColorConstants.white),
              ),
            ),
          )
        : CustomHtmlWidget(
            htmlString: data.feedTxt ?? '',
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
      imageUrl: data.files?.first.fileLoc ?? "",
      fit: BoxFit.cover,
    );
  }

  Row _buildReactionAndCommentCountSection(context) {
    return Row(
      children: [
        if (data.likeType != null && data.likeType!.isNotEmpty)
          Row(
            children: data.likeType!
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
                            reactionType: el.reactionType ?? '',
                            secondLike: true),
                        height: 16,
                        width: 16,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        if (data.likeType != null && data.likeType!.isNotEmpty)
          const SizedBox(width: 12),
        Expanded(
          child: Text(
            data.like != null
                ? 'You and ${data.likeCount} others'
                : '${data.likeCount} Reacted',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorConstants.grayDark2,
                    fontWeight: FontWeight.w700 )
          ),
        ),
        InkWell(
          onTap: () => commentsOnTap("${data.id}"),
          child: Row(
            children: [
              SvgPicture.asset(AssetConstants.comment),
              const SizedBox(width: 8),
              Text(
                '${data.commentCount} Comments',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorConstants.grayDark2,
                    fontWeight: FontWeight.w700 ) ,
              ),
            ],
          ),
        )
      ],
    );
  }

  Row _buildReactAndCommentButtonSection(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ReactionButton(
          toggle: false,
          direction: ReactionsBoxAlignment.ltr,
          onReactionChanged: (Reaction<String>? reaction) {
            onReactTap(reaction?.value ?? "");
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
                data.like != null
                    ? AppUtil.getReactionImage(
                        reactionType: data.like?.reactionType ?? '',
                        secondLike: false)
                    : AssetConstants.likeMiniFill,
                height: 20,
                width: 20,
                color: data.like != null
                    ? data.like!.reactionType == 'LIKE'
                        ? ColorConstants.indigo60
                        : null
                    : ColorConstants.grayDark,
              ),
              const SizedBox(width: 8),
              Text(
                data.like?.reactionType != null &&
                        data.like!.reactionType!.isNotEmpty
                    ? AppUtil.capitalizeFirst(data.like!.reactionType!)
                    : 'Like',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: data.like != null
                      ? data.like!.reactionType == 'LIKE'
                          ? ColorConstants.indigo60
                          : ColorConstants.grayDark
                      : ColorConstants.grayDark,
                  fontWeight: FontWeight.w600,)
              )
            ],
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: () {
            commentsOnTap("${data.id}");
          },
          child: Row(
            children: [
              Image.asset(AssetConstants.commentsFill, height: 20, width: 20,),
              const SizedBox(width: 4),
              Text(
                'Comment',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorConstants.black85,
                  fontWeight: FontWeight.w700,) ,
              ),
            ],
          ),
        )
      ],
    );
  }
}
