// To parse this JSON data, do
//
//     final modelMainSearchBrend = modelMainSearchBrendFromJson(jsonString);

import 'dart:convert';

ModelMainSearchBrend modelMainSearchBrendFromJson(String str) => ModelMainSearchBrend.fromJson(json.decode(str));

String modelMainSearchBrendToJson(ModelMainSearchBrend data) => json.encode(data.toJson());

class ModelMainSearchBrend {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  ModelMainSearchBrend({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory ModelMainSearchBrend.fromJson(Map<String, dynamic> json) => ModelMainSearchBrend(
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
  String? icon;
  String name;

  Result({
    required this.id,
    this.icon,
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