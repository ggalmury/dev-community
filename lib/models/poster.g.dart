// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poster.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Poster _$PosterFromJson(Map<String, dynamic> json) => Poster(
      uuid: json['uuid'] as String,
      nickname: json['nickname'] as String,
      profileImgUrl: json['profileImgUrl'] as String,
    );

Map<String, dynamic> _$PosterToJson(Poster instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'nickname': instance.nickname,
      'profileImgUrl': instance.profileImgUrl,
    };
