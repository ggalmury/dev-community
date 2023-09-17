import 'package:dev_community/models/user_account.dart';
import 'package:dev_community/utils/helpers/helper.dart';
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

  Future<void> setUserAccount(UserAccount userAccount) async {
    await pref.setString("uuid", userAccount.uuid);
    await pref.setString(
        "createdAT", Helper.dateToIsoString(userAccount.createdAt));
    userAccount.email != null &&
        await pref.setString("email", userAccount.email!);
    userAccount.nickname != null &&
        await pref.setString("nickname", userAccount.nickname!);
    userAccount.profileImgUrl != null &&
        await pref.setString("profileImgUrl", userAccount.profileImgUrl!);
    userAccount.kakaoId != null &&
        await pref.setInt("kakaoId", userAccount.kakaoId!);
    userAccount.kakaoEmail != null &&
        await pref.setString("kakaoEmail", userAccount.kakaoEmail!);
    userAccount.kakaoNickname != null &&
        await pref.setString("kakaoNickname", userAccount.kakaoNickname!);
    userAccount.kakaoProfileImgUrl != null &&
        await pref.setString(
            "kakaoProfileImgUrl", userAccount.kakaoProfileImgUrl!);
    userAccount.kakaoThumbnailImgUrl != null &&
        await pref.setString(
            "kakaoThumbnailImgUrl", userAccount.kakaoThumbnailImgUrl!);

    loggerNoStack.i("User account saved in key value store");
  }

  UserAccount getUserAccount() {
    String? uuid = pref.getString("uuid");

    if (uuid == null) {
      return UserAccount.init();
    }

    DateTime createdAt = DateTime.parse(pref.getString("createdAt")!);
    String? email = pref.getString("email");
    String? nickname = pref.getString("nickname");
    String? profileImgUrl = pref.getString("profileImgUrl");
    int? kakaoId = pref.getInt("kakaoId");
    String? kakaoEmail = pref.getString("kakaoEmail");
    String? kakaoNickname = pref.getString("kakaoNickname");
    String? kakaoProfileImgUrl = pref.getString("kakaoProfileImgUrl");
    String? kakaoThumbnailImgUrl = pref.getString("kakaoThumbnailImgUrl");

    loggerNoStack.i("User account loaded in key value store");

    return UserAccount(
        uuid: uuid,
        createdAt: createdAt,
        email: email,
        nickname: nickname,
        profileImgUrl: profileImgUrl,
        kakaoId: kakaoId,
        kakaoEmail: kakaoEmail,
        kakaoNickname: kakaoNickname,
        kakaoProfileImgUrl: kakaoProfileImgUrl,
        kakaoThumbnailImgUrl: kakaoThumbnailImgUrl);
  }

  Future<void> removeUserAccount() async {
    await pref.remove("uuid");
    await pref.remove("createdAT");
    await pref.remove("email");
    await pref.remove("nickname");
    await pref.remove("profileImgUrl");
    await pref.remove("kakaoId");
    await pref.remove("kakaoEmail");
    await pref.remove("kakaoNickname");
    await pref.remove("kakaoProfileImgUrl");
    await pref.remove("kakaoThumbnailImgUrl");

    loggerNoStack.i("User account reomved in key value store");
  }
}
