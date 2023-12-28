class ModelGetSizes {
  dynamic count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  ModelGetSizes({
    this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory ModelGetSizes.fromJson(Map<String, dynamic> json) => ModelGetSizes(
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
  dynamic name;

  Result({
    this.id,
    this.name,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
