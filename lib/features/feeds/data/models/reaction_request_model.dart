import 'package:dio/dio.dart';

import '../../../../app/helpers/utils/process_object.dart';

class ReactionRequest {
  final int feedId;
  final String action; //Create or Delete
  final String reactionType;
  final String reactionSource;

  ReactionRequest({
    required this.feedId,
    required this.action,
    required this.reactionType,
    this.reactionSource = "COMMUNITY",
  });

  Map<String, dynamic> toJson() => {
        "feed_id": feedId,
        "action": action,
        "reaction_type": reactionType,
        "reactionSource": reactionSource,
      };

  FormData toFormData() => processObject(toJson(), isFormData: true);
}
