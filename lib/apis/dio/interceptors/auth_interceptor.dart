import 'package:dev_community/repositories/key_value_store.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String? accessToken = KeyValueStore().getToken()?.accessToken;

    options.headers["Authorization"] = "Bearer $accessToken";

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: if 401, send refresh token and regenerate tokens
    /*
       if (response.statusCode == 401) {
      // 401 Unauthorized 응답이 왔을 때 토큰을 새로고침하고 재시도
      final refreshed = await refreshToken(); // refreshToken()은 새로운 토큰을 발급하는 메서드로 바꾸어야 합니다.

      if (refreshed) {
        // 토큰이 성공적으로 새로고쳐졌으면 이전 요청을 다시 보냅니다.
        final options = response.requestOptions;
        options.headers["Authorization"] = "Bearer ${KeyValueStore().getToken()?.accessToken}";
        try {
          final response = await dio?.request(options.path, options: options);
          handler.resolve(response!);
        } catch (e) {
          handler.reject(DioError(requestOptions: options, error: e.toString()));
        }
      } else {
        // 토큰 새로고침 실패 시 로그아웃 등의 처리를 수행합니다.
        // 예: 로그아웃 함수 호출
        // logout();
        handler.reject(DioError(requestOptions: response.requestOptions, error: "Token refresh failed"));
      }
    } else {
      handler.next(response);
    }
  }
    */
    handler.next(response);
  }
}
