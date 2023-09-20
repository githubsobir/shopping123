// To parse this JSON data, do
//
//     final modelCategoryGet = modelCategoryGetFromJson(jsonString);

import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
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

class CategoryNotifier extends StateNotifier<ModelProductList> {
  var box = Hive.box("online");

  // box.get("parentId");

  CategoryNotifier()
      : super(
            ModelProductList(count: "", next: "", previous: "", results: [])) {
    log("Konstruktor open page ---");
    getDataCategoryPage(
        modelSearch: ModelSearch(category: box.get("categoryId")));
  }

  ModelProductList modelProductListForCategory =
      ModelProductList(count: "", next: "", previous: "", results: []);

  Future<ModelProductList> getDataCategoryPage(
      {required ModelSearch modelSearch}) async {

    log("get Data Category page");
    var dio = Dio();
    List<ResultProductList> listProduct2 = [];
    if (modelSearch.page.toString() == "1" ||
        modelSearch.page.toString() == "null" ||
        modelSearch.page.toString() == "") {
      state = state.copyWith(results: []);
    }
    Response response = await dio.get(
        "${BaseClass.url}/api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
        options: Options(
            headers: {"X-Access-Token": "82f8ad497b5b70cfed09a68e522a3e94"}));
    log(modelSearch.page.toString());
    log(jsonEncode(response.data).toString());
    try {
      modelProductListForCategory = ModelProductList.fromJson(response.data);

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
      return ModelProductList(count: "", next: "", previous: "", results: []);
    }
  }

  void updateFavoriteBrand(String id) {
    List<ResultProductList> listUpFavBrand = [];
    listUpFavBrand.addAll(state.results);
    log(jsonEncode(state));

    for (int i = 0; i < listUpFavBrand.length; i++) {
      if (listUpFavBrand[i].id.toString() == id.toString()) {
        listUpFavBrand[i].isFavorite = !listUpFavBrand[i].isFavorite;
      }
    }

    state = state.copyWith(results: listUpFavBrand);
  }

  setOrdersBrand({required String idOrder}) {
    List<ResultProductList> updateOrder = [];
    updateOrder.addAll(state.results);
    log(updateOrder.toString());
    for (int i = 0; i < updateOrder.length; i++) {
      if (updateOrder[i].id.toString() == idOrder) {
        if (updateOrder[i].slug != "987654321") {
          /// order uchun parametr yoqligi uchun slug bilan ishlandi. orderga qiymat kelsa shuni olish kerak
          updateOrder[i].slug = "987654321";
        } else {
          updateOrder[i].slug = "slug";
        }
      }
    }
    state = state.copyWith(results: updateOrder);
  }

}
