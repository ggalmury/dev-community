import 'package:json_annotation/json_annotation.dart';

part 'user_account.g.dart';

@JsonSerializable()
class UserAccount {
  final String uuid;
  final DateTime createdAt;
  final String? email;
  final String? nickname;
  final String? profileImgUrl;
  final int? kakaoId;
  final String? kakaoEmail;
  final String? kakaoNickname;
  final String? kakaoProfileImgUrl;
  final String? kakaoThumbnailImgUrl;

  UserAccount(
      {required this.uuid,
      required this.createdAt,
      this.email,
      this.nickname,
      this.profileImgUrl,
      this.kakaoId,
      this.kakaoEmail,
      this.kakaoNickname,
      this.kakaoProfileImgUrl,
      this.kakaoThumbnailImgUrl});

  UserAccount.init()
      : uuid = "",
        createdAt = DateTime.now(),
        email = "",
        nickname = "",
        profileImgUrl = "",
        kakaoId = 0,
        kakaoEmail = "",
        kakaoNickname = "",
        kakaoProfileImgUrl = "",
        kakaoThumbnailImgUrl = "";

  factory UserAccount.fromJson(Map<String, dynamic> json) =>
      _$UserAccountFromJson(json);
  Map<String, dynamic> toJson() => _$UserAccountToJson(this);
}
