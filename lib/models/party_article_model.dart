class PartyArticleModel {
  final int id;
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

  PartyArticleModel(
      {required this.id,
      required this.poster,
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

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "poster": poster,
      "title": title,
      "description": description,
      "techSkill": techSkill,
      "position": position,
      "process": process,
      "category": category,
      "deadline": deadline,
      "startDate": startDate,
      "span": span,
      "location": location,
      "createdAt": createdAt
    };
  }

  factory PartyArticleModel.fromJson(Map<String, dynamic> json) {
    return PartyArticleModel(
      id: json["id"],
      poster: json["poster"],
      title: json["title"],
      description: json["description"],
      techSkill: (json["techSkill"] as List<dynamic>)
          .map((s) => s.toString())
          .toList(),
      position: (json["position"] as Map<String, dynamic>).map<String, int>(
        (k, v) => MapEntry<String, int>(k, v as int),
      ),
      process: json["process"],
      category: json["category"],
      deadline: DateTime.parse(json["deadline"]),
      startDate: DateTime.parse(json["startDate"]),
      span: json["span"],
      location: json["location"],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }
}
