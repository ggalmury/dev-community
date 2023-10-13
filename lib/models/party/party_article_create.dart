import 'package:json_annotation/json_annotation.dart';

part 'party_article_create.g.dart';

@JsonSerializable()
class PartyArticleCreate {
  final String category;
  final String title;
  final String? description;
  final List<String>? techSkill;
  final Map<String, int>? position;
  final String process;
  final String? location;
  final String deadline;
  final String startDate;
  final String span;

  const PartyArticleCreate(
      {required this.category,
      required this.title,
      this.description,
      this.techSkill,
      this.position,
      required this.process,
      this.location,
      required this.deadline,
      required this.startDate,
      required this.span});

  factory PartyArticleCreate.fromJson(Map<String, dynamic> json) =>
      _$PartyArticleCreateFromJson(json);

  Map<String, dynamic> toJson() => _$PartyArticleCreateToJson(this);
}
