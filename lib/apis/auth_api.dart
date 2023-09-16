import 'dart:convert';
import 'package:dev_community/models/user_account.dart';
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
        throw RequestCanceledException("User canceled Kakao login process");
      } else {
        throw NetworkException(
            "Error occured in requesting Kakao oAuth token process");
      }
    }

    Response response = await post(Uri.parse("$path/kakao"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"accessToken": oAuthToken.accessToken}));

    if (response.statusCode == 201) {
      UserAccount userAccount = UserAccount.fromJson(jsonDecode(response.body));

      return userAccount;
    } else {
      throw NetworkException("Error occured in Kakao login process");
    }
  }
}
