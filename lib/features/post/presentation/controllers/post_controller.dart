import 'package:ezycourse/app/base/base_controller.dart';
import 'package:ezycourse/app/widgets/toast/ezycourse_toast.dart';
import 'package:ezycourse/features/post/data/model/create_post_response_model.dart';
import 'package:ezycourse/features/post/domain/usecases/create_post_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../app/helpers/constants/app_constants.dart';
import '../../data/model/create_post_request_model.dart';

class PostController extends BaseController {
  final TextEditingController postTextController = TextEditingController();
  final RxInt selectedBgIndex = (-1).obs;

  final CreatePostUseCase _createPostUseCase =
      Get.find(tag: (CreatePostUseCase).toString());

  onCreatePost() {
    CreatePostRequest req = CreatePostRequest(
      feedTxt: postTextController.text,
      isBackground: selectedBgIndex.value == 0 ? 0 : 1,
      bgColor: selectedBgIndex.value == 0
          ? null
          : AppConstant.feedBackGroundGradientColors[(selectedBgIndex.value)],
    );
    final createPostService = _createPostUseCase.execute(req);
    callDataService(
      createPostService ,
      hideLoader: false,
      onSuccess: _handleCreatePostSuccess,
    );
  }

  _handleCreatePostSuccess(CreatePostResponse res) async {
    EzyCourseToast.success(msg: res.msg ?? "Succesfully Posted");
    Get.back(result: 'reload');
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
