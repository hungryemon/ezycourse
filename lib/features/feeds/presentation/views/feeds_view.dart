import 'package:ezycourse/app/helpers/constants/asset_constants.dart';
import 'package:ezycourse/features/feeds/presentation/widgets/create_post_card.dart';
import 'package:ezycourse/features/feeds/presentation/widgets/feed_card.dart';
import 'package:ezycourse/features/feeds/presentation/widgets/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../app/base/base_view.dart';
import '../../../../app/helpers/constants/color_constants.dart';
import '../../../../app/widgets/misc/paging_view.dart';
import '../controllers/feeds_controller.dart';

class FeedsView extends BaseView<FeedsController> {
  FeedsView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 144.h),
      child: Container(
        color: ColorConstants.deepGreen100,
        child: Padding(
            padding: EdgeInsets.only(top: 27.h, left: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    AssetConstants.drawer,
                    height: 32,
                    width: 32,
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: 6.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Python Developer Community',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: ColorConstants.white),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        '#General',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: ColorConstants.white),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }

  @override
  Widget? bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: 8.h, top: 5.h),
            child: SvgPicture.asset(
              AssetConstants.community,
            ),
          ),
          label: 'Community',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(4.h),
            child: SvgPicture.asset(
              AssetConstants.logout,
            ),
          ),
          label: 'Logout',
        ),
      ],
      iconSize: 24,
      selectedItemColor: ColorConstants.deepGreen110,
      unselectedItemColor: ColorConstants.black90,
      selectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: ColorConstants.deepGreen110,
          ),
      unselectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: ColorConstants.black90,
            fontWeight: FontWeight.w600,
          ),
      onTap: (int index) {
        if (index == 1) {
          showLogoutAlertDialog(
            context,
            onTapYes: () {
              controller.logout();
            },
          );
        }
      },
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() {
      return PagingView(
        onRefresh: () async {
          controller.initialize();
        },
        onLoadNextPage: () {
          controller.getMoreFeedList(lastFeedId: controller.feedlist.last.id);
        },
        isLoading: controller.isFeedPaginationLoading.value,
        child: Padding(
         padding: const EdgeInsets.fromLTRB(18, 25, 18, 25),
          child: Column(
            children: [
              CreatePostCard(controller: controller),
              const SizedBox(height: 30,),
              ListView.separated(
                shrinkWrap: true,
                itemCount: controller.feedlist.length,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var feed = controller.feedlist[index];
              
                  return FeedCard(
                      data: feed,
                      );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 16.h),
              ),
            ],
          ),
        ),
      );
    });
  }
}
