// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_article_creator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartyArticleCreator _$PartyArticleCreatorFromJson(Map<String, dynamic> json) =>
    PartyArticleCreator(
      poster: json['poster'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      techSkill:
          (json['techSkill'] as List<dynamic>).map((e) => e as String).toList(),
      position: Map<String, int>.from(json['position'] as Map),
      process: json['process'] as String,
      location: json['location'] as String?,
      deadline: json['deadline'] as String,
      startDate: json['startDate'] as String,
      span: json['span'] as String,
    );

Map<String, dynamic> _$PartyArticleCreatorToJson(
        PartyArticleCreator instance) =>
    <String, dynamic>{
      'poster': instance.poster,
      'category': instance.category,
      'title': instance.title,
      'description': instance.description,
      'techSkill': instance.techSkill,
      'position': instance.position,
      'process': instance.process,
      'location': instance.location,
      'deadline': instance.deadline,
      'startDate': instance.startDate,
      'span': instance.span,
    };
