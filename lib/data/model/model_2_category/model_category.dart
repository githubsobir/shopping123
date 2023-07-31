// To parse this JSON data, do
//
//     final modelCategoryGet = modelCategoryGetFromJson(jsonString);

import 'dart:convert';

ModelCategoryGet modelCategoryGetFromJson(String str) => ModelCategoryGet.fromJson(json.decode(str));

String modelCategoryGetToJson(ModelCategoryGet data) => json.encode(data.toJson());

class ModelCategoryGet {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  ModelCategoryGet({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory ModelCategoryGet.fromJson(Map<String, dynamic> json) => ModelCategoryGet(
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
  int? parent;
  List<Result> subcategories;

  Result({
    required this.id,
    this.icon,
    required this.name,
    this.parent,
    required this.subcategories,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    icon: json["icon"],
    name: json["name"],
    parent: json["parent"],
    subcategories: List<Result>.from(json["subcategories"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "icon": icon,
    "name": name,
    "parent": parent,
    "subcategories": List<dynamic>.from(subcategories.map((x) => x.toJson())),
  };
}
