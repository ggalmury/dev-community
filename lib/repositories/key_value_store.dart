import 'package:dev_community/models/token.dart';
import 'package:dev_community/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStore {
  static final KeyValueStore _instance = KeyValueStore._internal();
  late SharedPreferences pref;

  KeyValueStore._internal();

  factory KeyValueStore() {
    return _instance;
  }

  initialize() async {
    _instance.pref = await SharedPreferences.getInstance();
  }

  Future<void> setToken(Token token) async {
    await pref.setString("access_token", token.accessToken);
    await pref.setString("refresh_token", token.refreshToken);

    loggerNoStack.i("User account saved in key value store");
  }

  Token? getToken() {
    String? accessToken = pref.getString("access_token");
    String? refreshToken = pref.getString("refresh_token");

    if (accessToken == null || refreshToken == null) {
      loggerNoStack.i("Cannot find token in key value store");
      return null;
    }

    return Token(accessToken: accessToken, refreshToken: refreshToken);
  }

  Future<void> removeToken() async {
    await pref.remove("access_token");
    await pref.remove("refresh_token");

    loggerNoStack.i("Token removed in key value store");
  }
}
