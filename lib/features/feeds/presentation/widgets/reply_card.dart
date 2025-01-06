import 'package:ezycourse/features/feeds/data/models/reply_response_model.dart';
import 'package:flutter/material.dart';

import '../../../../app/helpers/constants/color_constants.dart';
import '../../../../app/widgets/misc/custom_network_image.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({super.key, required this.data});

  final ReplyResponse data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        ClipOval(
          child: CustomNetworkImage(
            imageUrl: data.user.profilePic,
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          ),
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
                            data.user.fullName,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorConstants.black, fontWeight: FontWeight.w600),
    
                          ),
                          Text(
                            data.commentTxt,
                   style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorConstants.grayLight2,),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8,),
                  const Icon(Icons.more_horiz_outlined,
                  color: ColorConstants.black60,
                  size: 22.24,
                  )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
