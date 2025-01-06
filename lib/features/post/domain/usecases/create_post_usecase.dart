

import '../../data/model/create_post_request_model.dart';
import '../../data/model/create_post_response_model.dart';
import '../repository/post_repository.dart';

class CreatePostUseCase {
  CreatePostUseCase({required this.repository});
  final PostRepository repository;

  Future<CreatePostResponse> execute(CreatePostRequest request) async {
    return repository.createPost(request);
  }
}
