// To parse this JSON data, do
//
//     final modelBanners = modelBannersFromJson(jsonString);

import 'dart:convert';

ModelBanners modelBannersFromJson(String str) => ModelBanners.fromJson(json.decode(str));

String modelBannersToJson(ModelBanners data) => json.encode(data.toJson());

class ModelBanners {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  ModelBanners({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory ModelBanners.fromJson(Map<String, dynamic> json) => ModelBanners(
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
  String icon;
  String name;

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
