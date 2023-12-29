class ModelGetBrands {
  dynamic count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  ModelGetBrands({
    this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory ModelGetBrands.fromJson(Map<String, dynamic> json) => ModelGetBrands(
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
  dynamic icon;
  dynamic name;

  Result({
    required this.id,
    required this.icon,
    required this.name,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    icon: json["icon"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "icon": icon,
    "name": name,
  };
}
