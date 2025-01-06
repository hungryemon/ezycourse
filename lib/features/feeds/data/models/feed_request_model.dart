import 'package:dio/dio.dart';

import '../../../../app/helpers/utils/process_object.dart';

class FeedRequest {
  int communityId;
  int spaceId;
  int? more;

  FeedRequest({
    this.communityId = 2914,
    this.spaceId = 5883,
    this.more,
  });

  FormData toFormData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['community_id'] = communityId;
    data['space_id'] = spaceId;
    data['more'] = more;

    return processObject(data, isFormData: true);
  }

  
}
