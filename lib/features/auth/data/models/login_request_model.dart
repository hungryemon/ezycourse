import 'package:dio/dio.dart';

import '../../../../app/helpers/utils/process_object.dart';

class LoginRequest {
  String email;
  String password;
  String appToken;

  LoginRequest({
    required this.email,
    required this.password,
    this.appToken = ''
  });

  FormData toFormData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['app_token'] = appToken;

    return processObject(data, isFormData: true);
  }
}
