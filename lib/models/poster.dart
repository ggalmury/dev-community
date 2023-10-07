import 'package:json_annotation/json_annotation.dart';

part 'poster.g.dart';

@JsonSerializable()
class Poster {
  final String uuid;
  final String nickname;
  final String profileImgUrl;

  Poster(
      {required this.uuid,
      required this.nickname,
      required this.profileImgUrl});

  factory Poster.fromJson(Map<String, dynamic> json) => _$PosterFromJson(json);
  Map<String, dynamic> toJson() => _$PosterToJson(this);
}
