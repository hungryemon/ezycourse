import 'dart:io';

import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

customImageViewFile({required String filePath}) async {
  await showImageViewer(Get.context!, Image.file(File(filePath)).image,
      onViewerDismissed: () {
    Get.back();
  }, swipeDismissible: true);
}

customImageViewNetwork({required String fileUrl}) async {
  await showImageViewer(
      Get.context!,
      Image.network(
        fileUrl,
      ).image,
       onViewerDismissed: () {
    Get.back();
  },
      swipeDismissible: true);
}
