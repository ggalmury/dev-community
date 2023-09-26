// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartyArticle _$PartyArticleFromJson(Map<String, dynamic> json) => PartyArticle(
      poster: json['poster'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      techSkill:
          (json['techSkill'] as List<dynamic>).map((e) => e as String).toList(),
      position: Map<String, int>.from(json['position'] as Map),
      process: json['process'] as String,
      category: json['category'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
      startDate: DateTime.parse(json['startDate'] as String),
      span: json['span'] as String,
      location: json['location'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PartyArticleToJson(PartyArticle instance) =>
    <String, dynamic>{
      'poster': instance.poster,
      'title': instance.title,
      'description': instance.description,
      'techSkill': instance.techSkill,
      'position': instance.position,
      'process': instance.process,
      'category': instance.category,
      'deadline': instance.deadline.toIso8601String(),
      'startDate': instance.startDate.toIso8601String(),
      'span': instance.span,
      'location': instance.location,
      'createdAt': instance.createdAt.toIso8601String(),
    };