import 'package:ezycourse/app/helpers/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helpers/utils/debouncer.dart';

class PagingView extends StatelessWidget {
  final Widget child;
  final Function() onLoadNextPage;
  final Future<void> Function()? onRefresh;
  final bool isLoading;

  ScrollController? scrollController;

  late final _debouncer = Debouncer(milliseconds: 500);

  PagingView({
    super.key,
    required this.child,
    required this.onLoadNextPage,
    this.onRefresh,
    this.scrollController,
    required this.isLoading,
  }) {
    scrollController ??= ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollController != null) {
          var triggerFetchMoreSize =
              0.75 * scrollController!.position.maxScrollExtent;

          if (scrollController!.position.pixels >= triggerFetchMoreSize &&
              (scrollController!.position.userScrollDirection ==
                  ScrollDirection.reverse)) {
            _debouncer.run(() {
              onLoadNextPage();
            });
          }
        }

        return true;
      },
      child: onRefresh == null
          ? _getScrollableView()
          : RefreshIndicator(
              child: _getScrollableView(),
              onRefresh: onRefresh!,
            ),
    );
  }

  _getScrollableView() {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          child,
          SizedBox(height: 12.h),
          if(isLoading)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: ColorConstants.deepGreen100,
                  strokeWidth: 0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 60.h),
        ],
      ),
    );
  }
}
