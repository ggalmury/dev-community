import 'package:dio/dio.dart';

class ContentTypeInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.contentType != null) {
      options.headers['Content-Type'] = options.contentType;
    } else {
      options.headers['Content-Type'] = 'application/json';
    }

    handler.next(options);
  }
}
