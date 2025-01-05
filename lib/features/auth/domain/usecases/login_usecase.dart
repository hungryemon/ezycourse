
import '../../data/models/login_request_model.dart';
import '../../data/models/login_response_model.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  LoginUseCase({required this.repository});
  final AuthRepository repository;

  Future<LoginResponse> execute(LoginRequest request) async {
    return repository.login(request);
  }
}
