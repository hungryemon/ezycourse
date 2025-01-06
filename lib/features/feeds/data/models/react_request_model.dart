import 'package:dio/dio.dart';

import '../../../../app/helpers/utils/process_object.dart';

class ReactRequest {
  final int feedId;
  final String action;
  final String reactionType;
  final String reactionSource;

  ReactRequest({
    required this.feedId,
    required this.action,
    required this.reactionType,
    required this.reactionSource,
  });

  Map<String, dynamic> toJson() => {
        "feed_id": feedId,
        "action": action,
        "reaction_type": reactionType,
        "reactionSource": reactionSource,
      };

   FormData toFormData() => processObject(toJson(), isFormData: true);
}