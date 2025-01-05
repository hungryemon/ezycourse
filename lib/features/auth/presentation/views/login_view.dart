
import 'package:flutter/material.dart';
import '../../../../app/base/base_view.dart';
import '../../../../app/helpers/constants/asset_constants.dart';
import '../controllers/login_controller.dart';
import '../widgets/login_form_section.dart';
import '../widgets/login_top_section.dart';

class LoginView extends BaseView<LoginController> {
  LoginView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetConstants.bg),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          const LoginTopSection(),
          Align(
            alignment: Alignment.bottomCenter,
            child: LoginFormSection(controller: controller),
          ),
        ],
      ),
    );
  }
}
