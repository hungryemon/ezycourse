import 'package:ezycourse/app/base/base_controller.dart';
import 'package:ezycourse/features/auth/data/models/logout_response_model.dart';
import 'package:get/get.dart';

import '../../../../app/helpers/utils/shared_pref_util.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/widgets/toast/ezycourse_toast.dart';
import '../../../auth/domain/usecases/logout_usecase.dart';

class FeedsController extends BaseController {

  final LogoutUseCase _logoutUseCase = Get.find(tag: (LogoutUseCase).toString());



  

  void logout(
  ) {
      final logoutService = _logoutUseCase.execute( );

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
