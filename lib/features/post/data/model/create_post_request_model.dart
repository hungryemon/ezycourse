import 'package:dio/dio.dart';
import 'package:ezycourse/app/helpers/utils/process_object.dart';

class CreatePostRequest {
  final String feedTxt;
  final int communityId;
  final int spaceId;
  final String uploadType;
  final String activityType;
  final int isBackground;
  final String? bgColor;

  CreatePostRequest({
    required this.feedTxt,
     this.communityId =2914,
    this.spaceId = 5883,
    this.uploadType = "text",
    this.activityType = "group",
    required this.isBackground,
    required this.bgColor,
  });

  Map<String, dynamic> toJson() => {
        "feed_txt": feedTxt,
        "community_id": communityId,
        "space_id": spaceId,
        "uploadType": uploadType,
        "activity_type": activityType,
        "is_background": isBackground,
        "bg_color": bgColor,
      };
  FormData toFormData() => processObject(toJson(), isFormData: true);
}
