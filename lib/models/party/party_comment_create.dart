import 'package:json_annotation/json_annotation.dart';

part 'party_comment_create.g.dart';

@JsonSerializable()
class PartyCommentCreate {
  final int postId;
  final String comment;
  final int depth;
  final int? group;

  PartyCommentCreate(
      {required this.postId,
      required this.comment,
      required this.depth,
      this.group});

  factory PartyCommentCreate.fromJson(Map<String, dynamic> json) =>
      _$PartyCommentCreateFromJson(json);
  Map<String, dynamic> toJson() => _$PartyCommentCreateToJson(this);
}
