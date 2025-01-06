import 'package:ezycourse/features/feeds/data/models/reaction_response_model.dart';

import '../../data/models/reaction_request_model.dart';
import '../repositories/feeds_repository.dart';

class SubmitReactionUseCase {
  SubmitReactionUseCase({required this.repository});
  final FeedsRepository repository;

  Future<ReactionResponse> execute(ReactionRequest req) async {
    return repository.submitReaction(req);
  }
}
