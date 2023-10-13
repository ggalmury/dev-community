import 'dart:convert';
import 'package:dev_community/apis/dio/dio_provider.dart';
import 'package:dev_community/models/auth/token.dart';
import 'package:dev_community/models/auth/user_account.dart';
import 'package:dev_community/utils/exceptions/authentication_exception.dart';
import 'package:dev_community/utils/exceptions/network_exception.dart';
import 'package:dev_community/utils/exceptions/request_canceled_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';

class AuthApi {
  final String path = "http://localhost:8080/auth";

  Future<UserAccount> fetchKakaoLogin() async {
    bool isKakaoInstalled = await isKakaoTalkInstalled();
    OAuthToken oAuthToken;

    try {
      oAuthToken = isKakaoInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();
    } catch (e) {
      if (e is PlatformException && e.code == "CANCELED") {
        throw RequestCanceledException();
      } else {
        throw NetworkException();
      }
    }

    Response response = await DioProvider().dio.post("$path/kakao",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${oAuthToken.accessToken}',
          },
        ));

    if (response.statusCode == 201) {
      UserAccount userAccount = UserAccount.fromJson(response.data);

      return userAccount;
    } else {
      throw NetworkException();
    }
  }

  Future<UserAccount> fetchAutoLogin(Token token) async {
    Response response = await DioProvider().dio.post("$path/auto-login",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${token.accessToken}',
            "X-Refresh-Token": token.refreshToken,
          },
        ));

    if (response.statusCode == 201) {
      UserAccount userAccount = UserAccount.fromJson(response.data);

      return userAccount;
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw NetworkException();
    }
  }

  Future<bool> fetchLogout(String uuid) async {
    Response response = await DioProvider()
        .dio
        .post("$path/logout", data: jsonEncode({"uuid": uuid}));

    if (response.statusCode == 201) {
      return true;
    } else {
      throw NetworkException();
    }
  }
}
