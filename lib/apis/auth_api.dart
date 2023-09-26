import 'dart:convert';
import 'package:dev_community/models/token.dart';
import 'package:dev_community/models/user_account.dart';
import 'package:dev_community/utils/exceptions/authentication_exception.dart';
import 'package:dev_community/utils/exceptions/network_exception.dart';
import 'package:dev_community/utils/exceptions/request_canceled_exception.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
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

    Response response = await post(Uri.parse("$path/kakao"), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${oAuthToken.accessToken}',
    });

    if (response.statusCode == 201) {
      UserAccount userAccount = UserAccount.fromJson(jsonDecode(response.body));

      return userAccount;
    } else {
      throw NetworkException();
    }
  }

  Future<UserAccount> fetchAutoLogin(Token token) async {
    Response response = await post(
      Uri.parse("$path/auto-login"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token.accessToken}',
        "X-Refresh-Token": token.refreshToken,
      },
    );

    if (response.statusCode == 201) {
      UserAccount userAccount = UserAccount.fromJson(jsonDecode(response.body));

      return userAccount;
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw NetworkException();
    }
  }

  Future<bool> fetchLogout(String uuid) async {
    Response response = await post(Uri.parse("$path/logout"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"uuid": uuid}));

    if (response.statusCode == 201) {
      return true;
    } else {
      throw NetworkException();
    }
  }
}
