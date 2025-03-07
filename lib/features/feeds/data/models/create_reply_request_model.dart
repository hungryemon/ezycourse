import 'package:dio/dio.dart';

import '../../../../app/helpers/utils/process_object.dart';

class CreateReplyRequest {
  final int feedId;
  final int feedUserId;
  final String commentTxt;
  final int parrentId;
  final String commentSource;

  CreateReplyRequest({
    required this.feedId,
    required this.feedUserId,
    required this.commentTxt,
    required this.parrentId,
    required this.commentSource,
  });

  Map<String, dynamic> toJson() => {
        "feed_id": feedId,
        "feed_user_id": feedUserId,
        "comment_txt": commentTxt,
        "parrent_id": parrentId,
        "commentSource": commentSource,
      };

   FormData toFormData() => processObject(toJson(), isFormData: true);
}