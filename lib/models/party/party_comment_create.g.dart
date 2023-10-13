// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_comment_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartyCommentCreate _$PartyCommentCreateFromJson(Map<String, dynamic> json) =>
    PartyCommentCreate(
      postId: json['postId'] as int,
      comment: json['comment'] as String,
      depth: json['depth'] as int,
      group: json['group'] as int?,
    );

Map<String, dynamic> _$PartyCommentCreateToJson(PartyCommentCreate instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'comment': instance.comment,
      'depth': instance.depth,
      'group': instance.group,
    };
