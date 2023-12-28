class ModelGetColor {
  dynamic count;
  dynamic next;
  dynamic previous;
  List<ResultGetColor> results;

  ModelGetColor({
    this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory ModelGetColor.fromJson(Map<String, dynamic> json) => ModelGetColor(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<ResultGetColor>.from(json["results"].map((x) => ResultGetColor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class ResultGetColor {
  dynamic id;
  dynamic code;
  dynamic name;

  ResultGetColor({
    this.id,
    this.code,
    this.name,
  });

  factory ResultGetColor.fromJson(Map<String, dynamic> json) => ResultGetColor(
    id: json["id"],
    code: json["code"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "name": name,
  };
}
