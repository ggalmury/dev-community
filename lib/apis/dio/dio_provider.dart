import 'package:dev_community/apis/dio/interceptors/auth_interceptor.dart';
import 'package:dev_community/apis/dio/interceptors/content_type_interceptor.dart';
import 'package:dio/dio.dart';

class DioProvider {
  static final DioProvider _instance = DioProvider._internal();
  late Dio dio;
  late Dio authDio;

  DioProvider._internal();

  factory DioProvider() {
    return _instance;
  }

  initialize() {
    _instance.dio = Dio();
    _instance.authDio = Dio();

    _instance.dio.interceptors.add(ContentTypeInterceptor());

    _instance.authDio.interceptors.add(ContentTypeInterceptor());
    _instance.authDio.interceptors.add(AuthInterceptor());
  }
}
