import 'package:dio/dio.dart';
import 'package:ezycourse/app/helpers/utils/shared_pref_util.dart';
import 'package:get/get.dart' hide Response;
import '../../app/helpers/utils/process_object.dart';
import '../../app/routes/app_routes.dart';

class RequestHeaderInterceptor extends InterceptorsWrapper {
  Map<String, dynamic> additionalHeader = {};

  final Dio dio = Dio();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    getCustomHeaders().then((customHeaders) {
      options.headers.addAll(customHeaders);
      super.onRequest(options, handler);
    });
  }


  @override
  void onError(err, handler) async {
    if (err.response?.statusCode == 401) {

     
        await SharedPrefUtil.setBearerToken('');
        await Get.offAllNamed(AppRoutes.login);
      } 
      
     else {
      super.onError(err, handler);
    }
  }



  Future<Map<String, dynamic>> getCustomHeaders() async {
    final String bearerToken =  SharedPrefUtil.getBearerToken();

    var customHeaders = processObject({
      'content-type': 'application/json',
      'Authorization': "Bearer $bearerToken",

    });

    return customHeaders;
  }
}
