import 'package:ezycourse/app/base/base_view.dart';
import 'package:ezycourse/app/widgets/toast/ezycourse_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/helpers/constants/app_constants.dart';
import '../../../../app/helpers/constants/color_constants.dart';
import '../controllers/post_controller.dart';

class PostView extends GetView {
  final PostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        //Status bar color for android
        statusBarColor: ColorConstants.transparent,
        systemNavigationBarColor: ColorConstants.transparent,
        systemNavigationBarDividerColor: ColorConstants.black,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        appBar: _buildHeader(context),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    maxLines: 6,
                    controller: controller.postTextController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "What’s on your mind?",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: ColorConstants.black60),
                      alignLabelWithHint: true,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: ColorConstants.white20)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: ColorConstants.white20)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: ColorConstants.white20)),
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: List.generate(
                    AppConstant.gradientsColor.length,
                    (i) => Obx(() {
                      controller.selectedBgIndex.value;
                      return Container(
                        margin: const EdgeInsets.only(right: 5),
                        child: InkWell(
                          onTap: () {
                            controller.selectedBgIndex(i);
                          },
                          child: Container(
                            height: 26,
                            width: 26,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              gradient: AppConstant.gradientsColor[i],
                            ),
                            child: controller.selectedBgIndex.value == i
                                ? const Icon(Icons.check)
                                : const SizedBox(),
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize _buildHeader(BuildContext context) {
    return PreferredSize(
        preferredSize: Size(double.infinity, 120.h),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Text(
                  'Close',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: ColorConstants.black40),
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create Post',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: ColorConstants.black,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              )),
              IconButton(
                onPressed: () {
                  if (controller.postTextController.text.isEmpty) {
                    EzyCourseToast.error(msg: "Write someting");
                    return;
                  }

                  controller.onCreatePost();
                },
                icon: Text(
                  'Create',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: ColorConstants.indigo80,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
        ));
  }
}
