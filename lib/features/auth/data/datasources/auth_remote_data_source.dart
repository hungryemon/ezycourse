import 'dart:isolate';

import 'package:dio/dio.dart';

import '../../../../app/base/base_remote_source.dart';
import '../../../../app/helpers/constants/api_constants.dart';
import '../../../../core/network/dio_provider.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/logout_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginRequest request);
  Future<LogoutResponse> logout();
}

class AuthRemoteDataSourceImpl extends BaseRemoteSource
    implements AuthRemoteDataSource {
  @override
  Future<LoginResponse> login(LoginRequest request) async {
    var endpoint =
        "${DioProvider.baseUrlPrimary}${ApiList.loginUrlWithPrimary}";
    var dioCall = dioClient.post(
      endpoint,
      data: request.toFormData(),
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseLoginResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse> _parseLoginResponse(Response<dynamic> response) async {
    LoginResponse loginResponse =
        await Isolate.run(() => LoginResponse.fromJson(response.data));
    return loginResponse;
  }
  
  @override
  Future<LogoutResponse> logout() {
     var endpoint =
        "${DioProvider.baseUrlSecondary}${ApiList.logoutUrlWithSecondary}";
    var dioCall = dioClient.post(
      endpoint,
    );

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseBaseResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  Future<LogoutResponse> _parseBaseResponse(Response<dynamic> response) async {
    LogoutResponse logoutResponse =
        await Isolate.run(() => LogoutResponse.fromJson(response.data));
    return logoutResponse;
  }
}
