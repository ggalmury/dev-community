import 'package:dev_community/models/common/comment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_group.g.dart';

@JsonSerializable()
class CommentGroup {
  final Comment comment;
  final List<Comment> subComment;

  CommentGroup({required this.comment, required this.subComment});

  factory CommentGroup.fromJson(Map<String, dynamic> json) =>
      _$CommentGroupFromJson(json);
  Map<String, dynamic> toJson() => _$CommentGroupToJson(this);
}
