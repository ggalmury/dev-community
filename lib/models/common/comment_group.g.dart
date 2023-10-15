// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentGroup _$CommentGroupFromJson(Map<String, dynamic> json) => CommentGroup(
      comment: Comment.fromJson(json['comment'] as Map<String, dynamic>),
      reply: (json['reply'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommentGroupToJson(CommentGroup instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'reply': instance.reply,
    };
