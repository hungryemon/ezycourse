import 'package:ezycourse/features/feeds/domain/repositories/feeds_repository.dart';

import '../../data/models/base_response_model.dart';
import '../../data/models/create_reply_request_model.dart';

class CreateReplyUseCase {
  CreateReplyUseCase({required this.repository});
  final FeedsRepository repository;

  Future<BaseResponse> execute(CreateReplyRequest req) async {
    return repository.createReply(req);
  }
}
