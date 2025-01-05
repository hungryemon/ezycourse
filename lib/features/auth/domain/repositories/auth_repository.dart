import 'package:ezycourse/features/auth/data/models/login_response_model.dart';
import 'package:get/get.dart';

import '../../../../app/base/base_remote_source.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/logout_response_model.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginRequest request);
  Future<LogoutResponse> logout();
}

class AuthRepositoryImpl extends BaseRemoteSource implements AuthRepository {
  final AuthRemoteDataSource _remoteSource =
      Get.find(tag: (AuthRemoteDataSource).toString());

  @override
  Future<LoginResponse> login(LoginRequest request) {
    return _remoteSource.login(request);
  }
  
  @override
  Future<LogoutResponse> logout() {
    return _remoteSource.logout();
  }
}
