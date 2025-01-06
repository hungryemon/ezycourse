import 'package:ezycourse/app/helpers/constants/color_constants.dart';
import 'package:ezycourse/app/routes/app_routes.dart';
import 'package:ezycourse/app/widgets/misc/custom_network_image.dart';
import 'package:ezycourse/features/feeds/presentation/controllers/feeds_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreatePostCard extends StatelessWidget {
  const CreatePostCard({super.key, required this.controller});
  final FeedsController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
     
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: ColorConstants.buttonBgColorSecondary.withOpacity(.2),
        ),
      ),
      child: Material(
        color: ColorConstants.transparent,
        child: InkWell(
          onTap: () async {
            dynamic result = await Get.toNamed(AppRoutes.createPost);
            if (result == 'reload') {
              controller.initialize();
            }
          },
          splashColor: ColorConstants.transparent,
          child: Padding(
             padding: const EdgeInsets.fromLTRB(12, 12, 20, 12),
            child: Row(
              children: [
                CustomNetworkImage(imageUrl: '', borderRadius: 4, height: 60, width: 54,),
                const SizedBox(width: 14),
               Text(
                  'Write Something here...',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: ColorConstants.grayLight,
                   
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color:  ColorConstants.buttonBgColorSecondary,
                  ),
                  child:  Text(
                    'Post',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorConstants.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
