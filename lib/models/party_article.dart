import 'package:json_annotation/json_annotation.dart';

part 'party_article.g.dart';

@JsonSerializable()
class PartyArticle {
  final String poster;
  final String title;
  final String? description;
  final List<String> techSkill;
  final Map<String, int> position;
  final String process;
  final String category;
  final DateTime deadline;
  final DateTime startDate;
  final String span;
  final String? location;
  final DateTime createdAt;

  PartyArticle(
      {required this.poster,
      required this.title,
      this.description,
      required this.techSkill,
      required this.position,
      required this.process,
      required this.category,
      required this.deadline,
      required this.startDate,
      required this.span,
      this.location,
      required this.createdAt});

  factory PartyArticle.fromJson(Map<String, dynamic> json) =>
      _$PartyArticleFromJson(json);
  Map<String, dynamic> toJson() => _$PartyArticleToJson(this);
}
