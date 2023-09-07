class PartyArticleCreateModel {
  final String poster;
  final String category;
  final String title;
  final String? description;
  final List<String> techSkill;
  final Map<String, int> position;
  final String process;
  final String location;
  final String deadline;
  final String startDate;
  final String span;

  const PartyArticleCreateModel(
      {required this.poster,
      required this.category,
      required this.title,
      required this.description,
      required this.techSkill,
      required this.position,
      required this.process,
      required this.location,
      required this.deadline,
      required this.startDate,
      required this.span});

  Map<String, dynamic> toJson() {
    return {
      "poster": poster,
      "category": category,
      "title": title,
      "description": description,
      "techSkill": techSkill,
      "position": position,
      "process": process,
      "location": location,
      "deadline": deadline,
      "startDate": startDate,
      "span": span,
    };
  }
}
