class PartyArticleModel {
  final String id;
  final DateTime createdDt;
  final String title;
  final String description;
  final List<String> techSkill;
  final List<String> position;
  final String process;
  final List<String> location;
  final String type;
  final DateTime deadline;
  final DateTime startDate;
  final String estimatedPeriod;

  PartyArticleModel(
      {required this.id,
      required this.createdDt,
      required this.title,
      required this.description,
      required this.techSkill,
      required this.position,
      required this.process,
      required this.location,
      required this.type,
      required this.deadline,
      required this.startDate,
      required this.estimatedPeriod});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "createdDt": createdDt,
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

  factory PartyArticleModel.fromJson(Map<String, dynamic> json) {
    return PartyArticleModel(
        id: json["id"],
        createdDt: json["createdDt"],
        title: json["title"],
        description: json["description"],
        techSkill: json["techSkill"],
        position: json["position"],
        process: json["process"],
        location: json["location"],
        type: json["type"],
        deadline: json["deadline"],
        startDate: json["startDate"],
        estimatedPeriod: json["estimatedPeriod"]);
  }
}
