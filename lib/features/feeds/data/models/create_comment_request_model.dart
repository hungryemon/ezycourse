import 'package:dio/dio.dart';

import '../../../../app/helpers/utils/process_object.dart';

class CreateCommentRequest {
  final int feedId;
  final int feedUserId;
  final String commentText;
  final String commentSource;

  CreateCommentRequest({
    required this.feedId,
    required this.feedUserId,
    required this.commentText,
    required this.commentSource,
  });

  Map<String, dynamic> toJson() => {
        "feed_id": feedId,
        "feed_user_id": feedUserId,
        "comment_txt": commentText,
        "commentSource": commentSource,
      };

  FormData toFormData() => processObject(toJson(), isFormData: true);
}
