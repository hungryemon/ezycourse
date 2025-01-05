import 'package:get/get.dart';

import '../controllers/feeds_controller.dart';

class FeedsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedsController>(
      () => FeedsController(),
    );
  }
}
