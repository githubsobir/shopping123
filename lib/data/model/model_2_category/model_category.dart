// To parse this JSON data, do
//
//     final modelCategoryGet = modelCategoryGetFromJson(jsonString);

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/network/base_url.dart';

ModelCategoryGet modelCategoryGetFromJson(String str) =>
    ModelCategoryGet.fromJson(json.decode(str));

String modelCategoryGetToJson(ModelCategoryGet data) =>
    json.encode(data.toJson());

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

  factory ModelCategoryGet.fromJson(Map<String, dynamic> json) =>
      ModelCategoryGet(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
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
        subcategories: List<Result>.from(
            json["subcategories"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "icon": icon,
        "name": name,
        "parent": parent,
        "subcategories":
            List<dynamic>.from(subcategories.map((x) => x.toJson())),
      };
}

class ModelProductListForCategory {
  dynamic count;
  dynamic next;
  dynamic previous;
  List<ResultProductListCategory> results;

  ModelProductListForCategory({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  ModelProductListForCategory copyWith({
    dynamic count,
    dynamic next,
    dynamic previous,
    required List<ResultProductListCategory> results,
  }) {
    return ModelProductListForCategory(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results);
  }

  factory ModelProductListForCategory.fromJson(Map<String, dynamic> json) =>
      ModelProductListForCategory(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<ResultProductListCategory>.from(
            json["results"].map((x) => ResultProductListCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ResultProductListCategory {
  dynamic id;
  dynamic name;
  dynamic slug;
  dynamic price;
  dynamic discount;
  dynamic newPrice;
  dynamic gender;
  dynamic type;
  dynamic season;
  dynamic material;
  dynamic brand;
  dynamic category;
  bool isFavorite;
  dynamic photo;
  dynamic rating;

  ResultProductListCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.price,
    required this.discount,
    required this.newPrice,
    required this.gender,
    required this.type,
    required this.season,
    required this.material,
    required this.brand,
    required this.category,
    required this.isFavorite,
    required this.photo,
    required this.rating,
  });

  factory ResultProductListCategory.fromJson(Map<String, dynamic> json) =>
      ResultProductListCategory(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        price: json["price"],
        discount: json["discount"],
        newPrice: json["new_price"],
        gender: json["gender"],
        type: json["type"],
        season: json["season"],
        material: json["material"],
        brand: json["brand"],
        category: json["category"],
        isFavorite: json["is_favorite"] ?? false,
        photo: json["photo"] ?? "",
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "price": price,
        "discount": discount,
        "new_price": newPrice,
        "gender": gender,
        "type": type,
        "season": season,
        "material": material,
        "brand": brand,
        "category": category,
        "is_favorite": isFavorite,
        "photo": photo,
        "rating": rating,
      };
}

class CategoryNotifier extends StateNotifier<ModelProductListForCategory> {
  CategoryNotifier()
      : super(ModelProductListForCategory(
            count: "", next: "", previous: "", results: [])){
     getDataCategoryPage(modelSearch: ModelSearch());
  }

  ModelProductListForCategory modelProductListForCategory =
      ModelProductListForCategory(
          count: "", next: "", previous: "", results: []);

  Future<ModelProductListForCategory> getDataCategoryPage(
      {required ModelSearch modelSearch}) async {
    var dio = Dio();
    List<ResultProductListCategory> listProduct2 = [];
    if (modelSearch.page.toString() == "1" ||
        modelSearch.page.toString() == "null") {
      state = state.copyWith(results: []);
    }
    Response response = await dio.get(
        "${BaseClass.url}/api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
        options: Options(
            headers: {"X-Access-Token": "82f8ad497b5b70cfed09a68e522a3e94"}));
    log(modelSearch.page.toString());
    log(jsonEncode(response.data).toString());
    try {
      modelProductListForCategory = ModelProductListForCategory.fromJson(response.data);

      if (modelSearch.page.toString() == "1" ||
          modelSearch.page.toString() == "null") {
        listProduct2.clear();
        listProduct2 = modelProductListForCategory.results;
        state = state.copyWith(results: listProduct2);

        return state;
      } else {
        listProduct2.addAll(modelProductListForCategory.results);
        state = state.copyWith(results: listProduct2);
        return state;
      }
    } catch (e) {
      log(e.toString());
      return ModelProductListForCategory(count: "", next: "", previous: "", results: []);
    }
  }
}
