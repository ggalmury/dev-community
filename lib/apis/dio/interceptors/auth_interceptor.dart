import 'package:dev_community/repositories/key_value_store.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? accessToken = KeyValueStore().getToken()?.accessToken;

    options.headers["Authorization"] = "Bearer $accessToken";

    handler.next(options);
  }
}
