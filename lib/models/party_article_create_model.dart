import 'package:json_annotation/json_annotation.dart';

part 'party_article_create_model.g.dart';

@JsonSerializable()
class PartyArticleCreateModel {
  final String poster;
  final String category;
  final String title;
  final String? description;
  final List<String> techSkill;
  final Map<String, int> position;
  final String process;
  final String? location;
  final String deadline;
  final String startDate;
  final String span;

  const PartyArticleCreateModel(
      {required this.poster,
      required this.category,
      required this.title,
      this.description,
      required this.techSkill,
      required this.position,
      required this.process,
      this.location,
      required this.deadline,
      required this.startDate,
      required this.span});

  factory PartyArticleCreateModel.fromJson(Map<String, dynamic> json) =>
      _$PartyArticleCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartyArticleCreateModelToJson(this);
}
