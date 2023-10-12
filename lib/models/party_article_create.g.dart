// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'party_article_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartyArticleCreate _$PartyArticleCreateFromJson(Map<String, dynamic> json) =>
    PartyArticleCreate(
      category: json['category'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      techSkill: (json['techSkill'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      position: (json['position'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as int),
      ),
      process: json['process'] as String,
      location: json['location'] as String?,
      deadline: json['deadline'] as String,
      startDate: json['startDate'] as String,
      span: json['span'] as String,
    );

Map<String, dynamic> _$PartyArticleCreateToJson(PartyArticleCreate instance) =>
    <String, dynamic>{
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
