import 'package:ezycourse/app/base/base_controller.dart';
import 'package:ezycourse/app/helpers/utils/shared_pref_util.dart';
import 'package:ezycourse/app/routes/app_routes.dart';
import 'package:ezycourse/app/widgets/toast/ezycourse_toast.dart';
import 'package:ezycourse/features/auth/data/models/login_request_model.dart';
import 'package:ezycourse/features/auth/data/models/login_response_model.dart';
import 'package:ezycourse/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final GlobalKey<FormState> userFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final LoginUseCase _loginUseCase = Get.find(tag: (LoginUseCase).toString());  

  void login(
    BuildContext context,
  ) {
    if (userFormKey.currentState!.validate()) {
      final loginService = _loginUseCase.execute(
        LoginRequest(
            email: emailController.text.trim(),
            password: passwordController.text),
      );

      callDataService(
        loginService,
        onSuccess: _handleLoginSuccess,
      );
    }
  }

  _handleLoginSuccess(LoginResponse res) {
    if (res.token.isNotEmpty) {
      SharedPrefUtil.setBearerToken(res.token);
      EzyCourseToast.success(
        msg: 'Login Success',
      );
      Get.offAllNamed(AppRoutes.feeds);
    }
  }

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    super.dispose();
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
