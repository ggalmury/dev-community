import 'package:dev_community/models/common/poster.dart';
import 'package:json_annotation/json_annotation.dart';

part 'party_article.g.dart';

@JsonSerializable()
class PartyArticle {
  final int id;
  final String title;
  final String? description;
  final List<String>? techSkill;
  final Map<String, int>? position;
  final String process;
  final String category;
  final DateTime deadline;
  final DateTime startDate;
  final String span;
  final String? location;
  final DateTime createdAt;
  final Poster poster;

  PartyArticle(
      {required this.id,
      required this.title,
      this.description,
      this.techSkill,
      this.position,
      required this.process,
      required this.category,
      required this.deadline,
      required this.startDate,
      required this.span,
      this.location,
      required this.createdAt,
      required this.poster});

  factory PartyArticle.fromJson(Map<String, dynamic> json) =>
      _$PartyArticleFromJson(json);
  Map<String, dynamic> toJson() => _$PartyArticleToJson(this);
}
