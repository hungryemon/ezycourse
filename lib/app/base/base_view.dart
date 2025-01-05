// ignore_for_file: depend_on_referenced_packages

import 'package:ezycourse/app/helpers/constants/color_constants.dart';
import 'package:ezycourse/app/widgets/toast/ezycourse_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../flavors/build_config.dart';
import '../helpers/page_state.dart';
import 'base_controller.dart';

// ignore: must_be_immutable
abstract class BaseView<Controller extends BaseController>
    extends GetView<Controller> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  final Logger logger = BuildConfig.instance.config.logger;

  BaseView({super.key});

  Widget body(
    BuildContext context,
  );

  PreferredSizeWidget? appBar(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          annotatedRegion(context),
          Obx(() => controller.pageState == PageState.LOADING
              ? _showLoading()
              : Container()),
          Obx(() => controller.errorMessage.isNotEmpty
              ? showErrorSnackBar(controller.errorMessage)
              : Container()),
          Container(),
        ],
      ),
    );
  }

  Widget annotatedRegion(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        //Status bar color for android
        statusBarColor: statusBarColor(context),
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness:
            Get.isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            Get.isDarkMode ? Brightness.light : Brightness.dark,
        statusBarBrightness:
            Get.isDarkMode ? Brightness.dark : Brightness.light,
      ),
      child: pageScaffold(context),
    );
  }

  // Widget pageSafeArea(BuildContext context) {
  //   return Material(
  //     color: Theme.of(context).scaffoldBackgroundColor,
  //     child: SafeArea(
  //       child: pageScaffold(context),
  //     ),
  //   );
  // }

  pageScaffold(BuildContext context) {
    return LayoutBuilder(builder: (contextLay, constraints) {
      return Scaffold(
        //sets ios status bar color
        extendBody: true,
        backgroundColor: pageBackgroundColor(context),
        key: globalKey,
        resizeToAvoidBottomInset: true,
        appBar: appBar(context),
        floatingActionButton: floatingActionButton(context),
        floatingActionButtonLocation: floatingActionButtonLocation,
        body: pageContent(context),
        bottomNavigationBar: bottomNavigationBar(context),
        drawer: drawer(context),
        endDrawer: endDrawer(context),
      );
    });
  }

  Widget pageContent(BuildContext context) {
    return body(context);
  }

  Widget showErrorSnackBar(String message) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      EzyCourseToast.error(msg: message, );
    });

    return Container();
  }

  Color pageBackgroundColor(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  Color statusBarColor(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  Widget? floatingActionButton(BuildContext context) {
    return null;
  }

  FloatingActionButtonLocation? floatingActionButtonLocation;

  Widget? bottomNavigationBar(BuildContext context) {
    return null;
  }

  Widget? endDrawer(BuildContext context) {
    return null;
  }

  Widget? drawer(BuildContext context) {
    return null;
  }

  Widget _showLoading() {
    return SizedBox(
      height: 40,
      width: 40,
      child: CircularProgressIndicator(color: ColorConstants.green100, ));
  }
}
