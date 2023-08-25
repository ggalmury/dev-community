class PartyArticleCreateModel {
  final String poster;
  final String? title;
  final String? description;
  final List<String>? techSkill;
  final Map<String, Map<String, int>>? position;
  final String? process;
  final String? location;
  final String? type;
  final DateTime? deadline;
  final DateTime? startDate;
  final String? estimatedPeriod;

  const PartyArticleCreateModel(
      {required this.poster,
      this.title,
      this.description,
      this.techSkill,
      this.position,
      this.process,
      this.location,
      this.type,
      this.deadline,
      this.startDate,
      this.estimatedPeriod});

  Map<String, dynamic> toJson() {
    return {
      "poster": poster,
      "title": title,
      "description": description,
      "techSkill": techSkill,
      "position": position,
      "process": process,
      "location": location,
      "type": type,
      "deadline": deadline,
      "startDate": startDate,
      "estimatedPeriod": estimatedPeriod,
    };
  }

  PartyArticleCreateModel copyWith({
    String? poster,
    String? title,
    String? description,
    List<String>? techSkill,
    Map<String, Map<String, int>>? position,
    String? process,
    String? location,
    String? type,
    DateTime? deadline,
    DateTime? startDate,
    String? estimatedPeriod,
  }) {
    return PartyArticleCreateModel(
      poster: poster ?? this.poster,
      title: title ?? this.title,
      description: description ?? this.description,
      techSkill: techSkill ?? this.techSkill,
      position: position ?? this.position,
      process: process ?? this.process,
      location: location ?? this.location,
      type: type ?? this.type,
      deadline: deadline ?? this.deadline,
      startDate: startDate ?? this.startDate,
      estimatedPeriod: estimatedPeriod ?? this.estimatedPeriod,
    );
  }
}
