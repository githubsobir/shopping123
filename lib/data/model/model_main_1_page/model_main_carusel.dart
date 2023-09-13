class ModelMainPageCarusel {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  ModelMainPageCarusel({
    required this.count,
    required this.next,
    required this.previous,
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
  dynamic id;
  dynamic updatedAt;
  dynamic createdAt;
  dynamic title;
  dynamic type;
  dynamic image;
  dynamic deadline;
  bool isActive;

  Result({
    required this.id,
    required this.updatedAt,
    required this.createdAt,
    required this.title,
    required this.type,
    required this.image,
    required this.deadline,
    required this.isActive,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"]??"",
    updatedAt: json["updated_at"]??"",
    createdAt:json["created_at"]??"",
    title: json["title"]??"",
    type: json["type"]??"",
    image: json["image"]??"",
    deadline: json["deadline"]??"",
    isActive: json["is_active"]??false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "title": title,
    "type": type,
    "image": image,
    "deadline": deadline,
    "is_active": isActive,
  };
}
