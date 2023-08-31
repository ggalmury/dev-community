class PartyArticleModel {
  final String id;
  final DateTime createdDt;
  final String poster;
  final String title;
  final String description;
  final List<String> techSkill;
  final Map<String, Map<String, int>> position;
  final String process;
  final String type;
  final DateTime deadline;
  final DateTime startDate;
  final String span;
  final String? location;

  PartyArticleModel(
      {required this.id,
      required this.createdDt,
      required this.poster,
      required this.title,
      required this.description,
      required this.techSkill,
      required this.position,
      required this.process,
      required this.type,
      required this.deadline,
      required this.startDate,
      required this.span,
      this.location});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "createdDt": createdDt,
      "poster": poster,
      "title": title,
      "description": description,
      "techSkill": techSkill,
      "position": position,
      "process": process,
      "type": type,
      "deadline": deadline,
      "startDate": startDate,
      "span": span,
      "location": location,
    };
  }

  factory PartyArticleModel.fromJson(Map<String, dynamic> json) {
    return PartyArticleModel(
      id: json["id"],
      createdDt: json["createdDt"],
      poster: json["poster"],
      title: json["title"],
      description: json["description"],
      techSkill: json["techSkill"],
      position: json["position"],
      process: json["process"],
      type: json["type"],
      deadline: json["deadline"],
      startDate: json["startDate"],
      span: json["span"],
      location: json["location"],
    );
  }
}
