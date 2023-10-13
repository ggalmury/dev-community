import 'package:dev_community/models/common/poster.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int id;
  final int postId;
  final String comment;
  final DateTime createdAt;
  final int group;
  final int depth;
  final Poster poster;

  Comment(
      {required this.id,
      required this.postId,
      required this.comment,
      required this.createdAt,
      required this.group,
      required this.depth,
      required this.poster});

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
