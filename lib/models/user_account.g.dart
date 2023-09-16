// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccount _$UserAccountFromJson(Map<String, dynamic> json) => UserAccount(
      uuid: json['uuid'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      email: json['email'] as String?,
      nickname: json['nickname'] as String?,
      profileImgUrl: json['profileImgUrl'] as String?,
      kakaoId: json['kakaoId'] as int?,
      kakaoEmail: json['kakaoEmail'] as String?,
      kakaoNickname: json['kakaoNickname'] as String?,
      kakaoProfileImgUrl: json['kakaoProfileImgUrl'] as String?,
      kakaoThumbnailImgUrl: json['kakaoThumbnailImgUrl'] as String?,
    );

Map<String, dynamic> _$UserAccountToJson(UserAccount instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'createdAt': instance.createdAt.toIso8601String(),
      'email': instance.email,
      'nickname': instance.nickname,
      'profileImgUrl': instance.profileImgUrl,
      'kakaoId': instance.kakaoId,
      'kakaoEmail': instance.kakaoEmail,
      'kakaoNickname': instance.kakaoNickname,
      'kakaoProfileImgUrl': instance.kakaoProfileImgUrl,
      'kakaoThumbnailImgUrl': instance.kakaoThumbnailImgUrl,
    };
