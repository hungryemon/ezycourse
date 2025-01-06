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
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorConstants.black110,
                      fontWeight: FontWeight.bold)),
              Text(
                  AppUtil.displayTimeAgoFromTimestamp(
                      data.createdAt),
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
                    ?.copyWith(color: ColorConstants.black),
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
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorConstants.grayDark2,
                  fontWeight: FontWeight.w700)),
        ),
        InkWell(
          onTap: () => commentsOnTap("${data.id}"),
          child: Row(
            children: [
              SvgPicture.asset(AssetConstants.comment),
              const SizedBox(width: 8),
              Text(
                '${data.commentCount} Comments',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorConstants.grayDark2,
                    fontWeight: FontWeight.w700),
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
        CustomReactionWidget(onReactTap: onReactTap, data: data),
        Container(
          width: 0.64,
          height: 15.35,
          color: ColorConstants.grayLight,
        ),
        InkWell(
          onTap: () {
            commentsOnTap("${data.id}");
          },
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

  final Function(String text) onReactTap;
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
      toggle: _reaction.isNotEmpty,
      direction: ReactionsBoxAlignment.ltr,
      onReactionChanged: (Reaction<String>? reaction) {
        widget.onReactTap(reaction?.value ?? "");
        if (_reaction.isNotEmpty) {
          _reaction = '';
        } else {
          _reaction = reaction?.value ?? '';
        }
        setState(() {
          _reaction = reaction?.value?.toUpperCase() ?? '';
        });
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
