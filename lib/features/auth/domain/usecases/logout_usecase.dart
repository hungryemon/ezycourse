
import '../../data/models/logout_response_model.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase {
  LogoutUseCase({required this.repository});
  final AuthRepository repository;

  Future<LogoutResponse> execute() async {
    return repository.logout();
  }
}