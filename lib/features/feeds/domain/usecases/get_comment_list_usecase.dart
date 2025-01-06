import 'package:ezycourse/features/feeds/data/models/comment_response_model.dart';

import '../repositories/feeds_repository.dart';

class GetCommentListUseCase {
  GetCommentListUseCase({required this.repository});
  final FeedsRepository repository;

  Future<List<CommentResponse>> call(int id) async {
    return repository.getCommentList(id);
  }
}
