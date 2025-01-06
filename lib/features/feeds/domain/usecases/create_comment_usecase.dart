import 'package:ezycourse/features/feeds/data/models/create_comment_request_model.dart';
import 'package:ezycourse/features/feeds/domain/repositories/feeds_repository.dart';

import '../../data/models/base_response_model.dart';

class CreateCommentUseCase {
  CreateCommentUseCase({required this.repository});
  final FeedsRepository repository;

  Future<BaseResponse> execute(CreateCommentRequest req) async {
    return repository.createComment(req);
  }
}
