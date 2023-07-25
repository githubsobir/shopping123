class ModelMainPageCarusel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  ModelMainPageCarusel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory ModelMainPageCarusel.fromJson(Map<String, dynamic> json) => ModelMainPageCarusel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  int id;
  DateTime updatedAt;
  DateTime createdAt;
  String title;
  String image;
  DateTime deadline;
  bool isActive;

  Result({
    required this.id,
    required this.updatedAt,
    required this.createdAt,
    required this.title,
    required this.image,
    required this.deadline,
    required this.isActive,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    title: json["title"],
    image: json["image"],
    deadline: DateTime.parse(json["deadline"]),
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "title": title,
    "image": image,
    "deadline": deadline.toIso8601String(),
    "is_active": isActive,
  };
}
