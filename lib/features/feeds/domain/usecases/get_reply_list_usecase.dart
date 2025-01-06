import 'package:ezycourse/features/feeds/data/models/reply_response_model.dart';

import '../repositories/feeds_repository.dart';

class GetReplyListUseCase {
  GetReplyListUseCase({required this.repository});
  final FeedsRepository repository;

  Future<List<ReplyResponse>> call(int id) async {
    return repository.getReplyList(id);
  }
}
