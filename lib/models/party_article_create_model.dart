class PartyArticleCreateModel {
  final String poster;
  final String type;
  final String? title;
  final String? description;
  final List<String>? techSkill;
  final Map<String, int>? position;
  final String? process;
  final String? location;
  final DateTime? deadline;
  final DateTime? startDate;
  final String? estimatedPeriod;

  const PartyArticleCreateModel(
      {required this.poster,
      required this.type,
      this.title,
      this.description,
      this.techSkill,
      this.position,
      this.process,
      this.location,
      this.deadline,
      this.startDate,
      this.estimatedPeriod});

  Map<String, dynamic> toJson() {
    return {
      "poster": poster,
      "type": type,
      "title": title,
      "description": description,
      "techSkill": techSkill,
      "position": position,
      "process": process,
      "location": location,
      "deadline": deadline,
      "startDate": startDate,
      "estimatedPeriod": estimatedPeriod,
    };
  }

  PartyArticleCreateModel copyWith({
    String? poster,
    String? type,
    String? title,
    String? description,
    List<String>? techSkill,
    Map<String, int>? position,
    String? process,
    String? location,
    DateTime? deadline,
    DateTime? startDate,
    String? estimatedPeriod,
  }) {
    return PartyArticleCreateModel(
      poster: poster ?? this.poster,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      techSkill: techSkill ?? this.techSkill,
      position: position ?? this.position,
      process: process ?? this.process,
      location: location ?? this.location,
      deadline: deadline ?? this.deadline,
      startDate: startDate ?? this.startDate,
      estimatedPeriod: estimatedPeriod ?? this.estimatedPeriod,
    );
  }
}
