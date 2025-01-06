import 'package:ezycourse/features/feeds/data/models/base_response_model.dart';

import '../../data/models/react_request_model.dart';
import '../repositories/feeds_repository.dart';

class SubmitReactionUseCase {
  SubmitReactionUseCase({required this.repository});
  final FeedsRepository repository;

  Future<BaseResponse> execute(ReactRequest req) async {
    return repository.submitReaction(req);
  }
}
