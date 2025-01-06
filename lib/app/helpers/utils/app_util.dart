import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../constants/asset_constants.dart';

class AppUtil {
  static String displayTimeAgoFromTimestamp(String timestamp) {
    final year = int.parse(timestamp.substring(0, 4));
    final month = int.parse(timestamp.substring(5, 7));
    final day = int.parse(timestamp.substring(8, 10));
    final hour = int.parse(timestamp.substring(11, 13));
    final minute = int.parse(timestamp.substring(14, 16));

    final DateTime dateTime = DateTime(year, month, day, hour, minute);
    final int diffInHours = DateTime.now().difference(dateTime).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;

    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(dateTime).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'minute';
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'hour';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'day';
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit = 'week';
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit = 'month';
    } else {
      timeValue = (diffInHours / (24 * 365)).floor();
      timeUnit = 'year';
    }

    timeAgo = '$timeValue $timeUnit';
    timeAgo += timeValue > 1 ? 's' : '';

    return '$timeAgo ago';
  }

  static LinearGradient getGradiant(String text) {
    for (var i = 0; i < AppConstant.feedBackGroundGradientColors.length; i++) {
      if (text == AppConstant.feedBackGroundGradientColors[i]) {
        return AppConstant.gradientsColor[i + 1];
      }
    }

    return AppConstant.gradientsColor[0];
  }

  static String getReactionImage({
    required String reactionType,
    required bool secondLike,
  }) {
    switch (reactionType.toUpperCase()) {
      case "LIKE":
        return secondLike ? AssetConstants.likeMini : AssetConstants.likeMiniFill;
      case "LOVE":
        return AssetConstants.love;
      case "CARE":
        return AssetConstants.care;
      case "HAHA":
        return AssetConstants.haha;
      case "WOW":
        return AssetConstants.wow;
      case "SAD":
        return AssetConstants.sad;
      case "ANGRY":
        return AssetConstants.angry;

      default:
        return AssetConstants.likeMini;
    }
  }

  static String capitalizeFirst(String input) {
  if (input.isEmpty) return input; // Handle empty strings
  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}
}
