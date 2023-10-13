// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as int,
      postId: json['postId'] as int,
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      group: json['group'] as int,
      depth: json['depth'] as int,
      poster: Poster.fromJson(json['poster'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'comment': instance.comment,
      'createdAt': instance.createdAt.toIso8601String(),
      'group': instance.group,
      'depth': instance.depth,
      'poster': instance.poster,
    };
