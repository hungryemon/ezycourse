import 'package:dio/dio.dart';
import 'package:ezycourse/app/helpers/utils/shared_pref_util.dart';

import 'dio_provider.dart';

class DioRequestRetrier {
  final dioClient = DioProvider.tokenClient;
  final RequestOptions requestOptions;



  DioRequestRetrier({required this.requestOptions});

  Future<Response<T>> retry<T>() async {
    var header = getCustomHeaders();

    return await dioClient.request(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      options: Options(headers: header, method: requestOptions.method),
    );
  }

  Map<String, String> getCustomHeaders()  {
    final String bearerToken =  SharedPrefUtil.getBearerToken();
    var customHeaders = {'content-type': 'application/json'};
    if (bearerToken.trim().isNotEmpty) {
      customHeaders.addAll({
        'Authorization': "Bearer $bearerToken",
      });
    }

    return customHeaders;
  }
}
