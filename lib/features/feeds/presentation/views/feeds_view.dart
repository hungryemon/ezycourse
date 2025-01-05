import 'package:flutter/material.dart';

import '../../../../app/base/base_view.dart';
import '../controllers/feeds_controller.dart';

class FeedsView extends BaseView<FeedsController> {
  FeedsView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      title: Text('Feeds'),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Text('Feeds'),
    );
  }
}
