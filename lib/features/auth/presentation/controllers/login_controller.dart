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
  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  initialize() {
    emailController.text = SharedPrefUtil.getEmail();
    passwordController.text = SharedPrefUtil.getPassword();
    isRememberMe(SharedPrefUtil.getIsRememberMe());
  }

  final GlobalKey<FormState> userFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isRememberMe = false.obs;
  final RxBool isLoading = false.obs;

  final LoginUseCase _loginUseCase = Get.find(tag: (LoginUseCase).toString());

  void login(
    BuildContext context,
  ) {
    if (userFormKey.currentState!.validate()) {
      isLoading(true);
      final loginService = _loginUseCase.execute(
        LoginRequest(
            email: emailController.text.trim(),
            password: passwordController.text),
      );

      callDataService(loginService,
          hideLoader: true, onSuccess: _handleLoginSuccess, onComplete: () {
        isLoading(false);
      });
    }
  }

  _handleLoginSuccess(LoginResponse res) {
    if (res.token.isNotEmpty) {
      SharedPrefUtil.setBearerToken(res.token);
      if (SharedPrefUtil.getIsRememberMe()) {
        SharedPrefUtil.setEmail(emailController.text);
        SharedPrefUtil.setPassword(passwordController.text);
      } else {
        SharedPrefUtil.setEmail('');
        SharedPrefUtil.setPassword('');
      }
      EzyCourseToast.success(
        msg: 'Login Success',
      );
      Get.offAllNamed(AppRoutes.feeds);
    }
  }

  onPressRememberMe(bool value) {
    isRememberMe(value);
    SharedPrefUtil.setIsRememberMe(value);
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
