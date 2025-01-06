import 'package:ezycourse/app/base/base_controller.dart';
import 'package:ezycourse/features/auth/data/models/logout_response_model.dart';
import 'package:ezycourse/features/feeds/data/models/feed_request_model.dart';
import 'package:ezycourse/features/feeds/data/models/feed_response_model.dart';
import 'package:ezycourse/features/feeds/domain/usecases/get_feed_list_usecase.dart';
import 'package:get/get.dart';

import '../../../../app/helpers/utils/shared_pref_util.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/widgets/toast/ezycourse_toast.dart';
import '../../../auth/domain/usecases/logout_usecase.dart';

class FeedsController extends BaseController {
  @override
  void onInit() {
    getFeedList();
    super.onInit();
  }

  initialize() {
    getFeedList();
  }

  final LogoutUseCase _logoutUseCase =
      Get.find(tag: (LogoutUseCase).toString());
  final GetFeedListUseCase _getFeedListUseCase =
      Get.find(tag: (GetFeedListUseCase).toString());

  final RxBool isFeedPaginationLoading = false.obs;

  final RxList<FeedResponse> _feedList = RxList.empty();
  List<FeedResponse> get feedlist => _feedList();

  void getFeedList() {
    if (isFeedPaginationLoading.value) return;
    final getFeedListService = _getFeedListUseCase.execute(FeedRequest());
    callDataService(
      getFeedListService,
      hideLoader: false,
      onSuccess: _handleFeedListSuccess,
    );
  }

  _handleFeedListSuccess(List<FeedResponse> res) async {
    _feedList(res);
  }

  void getMoreFeedList({int? lastFeedId}) {
    if (isFeedPaginationLoading.value) return;
    isFeedPaginationLoading(true);
    final getMoreFeedListService =
        _getFeedListUseCase.execute(FeedRequest(more: lastFeedId));
    callDataService(
      getMoreFeedListService,
      hideLoader: true,
      onComplete: () {
        isFeedPaginationLoading(false);
      },
      onSuccess: _handleMoreFeedListSuccess,
    );
  }

  _handleMoreFeedListSuccess(List<FeedResponse> res) async {
    _feedList.addAll(res);
  }

  void logout() {
    final logoutService = _logoutUseCase.execute();
    callDataService(
      logoutService,
      hideLoader: false,
      onSuccess: _handleLogoutSuccess,
    );
  }

  _handleLogoutSuccess(LogoutResponse res) async {
    SharedPrefUtil.setBearerToken('');

    EzyCourseToast.success(
      msg: res.msg ?? "Logged Out",
    );
    await Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
