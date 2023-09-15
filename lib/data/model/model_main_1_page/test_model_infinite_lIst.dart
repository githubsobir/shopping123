import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/network/base_url.dart';

class ModelProductList {
  dynamic count;
  dynamic next;
  dynamic previous;
  List<ResultProductList> results;

  ModelProductList({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  ModelProductList copyWith({
    dynamic count,
    dynamic next,
    dynamic previous,
    required List<ResultProductList> results,
  }) {
    return ModelProductList(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results);
  }

  factory ModelProductList.fromJson(Map<String, dynamic> json) =>
      ModelProductList(
        count: json["count"]??"",
        next: json["next"]??"",
        previous: json["previous"]??"",
        results: List<ResultProductList>.from(
            json["results"].map((x) => ResultProductList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ResultProductList {
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
  dynamic isFavorite;
  dynamic photo;
  dynamic rating;

  ResultProductList({
     this.id,
     this.name,
     this.slug,
     this.price,
     this.discount,
     this.newPrice,
     this.gender,
     this.type,
     this.season,
     this.material,
     this.brand,
     this.category,
     this.isFavorite,
     this.photo,
     this.rating,
  });



  factory ResultProductList.fromJson(Map<String, dynamic> json) =>
      ResultProductList(
        id: json["id"]??"",
        name: json["name"]??"",
        slug: json["slug"]??"",
        price: json["price"]??0??"",
        discount: json["discount"]??0??"",
        newPrice: json["new_price"]??-1.00,
        gender: json["gender"]??"",
        type: json["type"]??"",
        season: json["season"]??"",
        material: json["material"]??"",
        brand: json["brand"]??"",
        category: json["category"]??"",
        isFavorite: json["is_favorite"] ?? false,
        photo: json["photo"] ?? "https://uzb.technostudio.uz/media/Banner/bann.jpg",
        rating: json["rating"]??-1,
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

/// product is favourite, basket-karzinka
class ModelProductListNotifier extends StateNotifier<ModelProductList> {
  ModelProductListNotifier()
      : super(
            ModelProductList(count: "1", next: "", previous: "", results: [])) {
    getData(modelSearch: ModelSearch());
  }

  late ModelProductList modelProductList =
      ModelProductList(count: "1", next: "", previous: "", results: []);
  List<ResultProductList> listProducts = [];
  List<ResultProductList> listProduct2 = [];
  var dio = Dio();

  Future<ModelProductList> getData({required ModelSearch modelSearch}) async {


    if (modelSearch.page.toString() == "1" ||
        modelSearch.page.toString() == "null"
    ) {
      state = state.copyWith(results: []);
    }
    Response response = await dio.get(
        "${BaseClass.url}/api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
        options: Options(
            headers: {"X-Access-Token": "82f8ad497b5b70cfed09a68e522a3e94"}));
log(jsonEncode(response.data).toString());
    try {
      modelProductList = ModelProductList.fromJson(response.data);


      if (modelSearch.page.toString() == "1" ||
          modelSearch.page.toString() == "null"
      ) {
        listProduct2.clear();
        listProduct2 = modelProductList.results;
        state = state.copyWith(results: listProduct2);
        return state;
      } else {
        listProduct2.addAll(modelProductList.results);
        state = state.copyWith(results: listProduct2);
        return state;
      }
    } catch (e) {
      log(e.toString());
      return ModelProductList(count: "", next: "", previous: "", results: []);
    }
  }

  List<ResultProductList> getList() {
    return state.results;
  }

  updateFavorite(String id) {
    List<ResultProductList> updateFav = [...state.results];
    for (int i = 0; i < updateFav.length; i++) {
      if (updateFav[i].id.toString() == id.toString()) {
        log(updateFav[i].isFavorite.toString());
        updateFav[i].isFavorite = !updateFav[i].isFavorite;

        state = state.copyWith(results: updateFav);

        // state.results = updateFav;
        log(state.results[i].isFavorite.toString());
      }
    }
  }

  getFavorite() {
    List<ResultProductList> list = [];
    list.addAll(state.results);
    for (int i = 0; i < list.length; i++) {
      if (state.results[i].isFavorite) {
        list.add(state.results[i]);
      }
    }
    state = state.copyWith(results: list);
    return state;
  }

  setOrder({required String idOrder}) {
    List<ResultProductList> updateOrder = [...state.results];
    for (int i = 0; i < updateOrder.length; i++) {
      if (updateOrder[i].id.toString() == idOrder.toString()) {
        if (updateOrder[i].slug != "987654321") {
          /// order uchun parametr yoqligi uchun slug bilan ishlandi. orderga qiymat kelsa shuni olish kerak
          updateOrder[i].slug = "987654321";
        } else {
          updateOrder[i].slug = "slug";
        }
      }
    }
    state = state.copyWith(results: updateOrder);
    return state;
  }

  List<ResultProductList> getOrder() {
    List<ResultProductList> list = [];
    list.addAll(state.results);
    for (int i = 0; i < list.length; i++) {
      if (list[i].slug.toString() == "987654321") {
        // list.add(state.results[i]);
        // state = state.copyWith(results: )
      }
    }
    return state.results;
  }
}

/// search
class ModelSearchListNotifier extends StateNotifier<List<ResultProductList>> {
  ModelSearchListNotifier() : super([]);

  var dio = Dio();
  late ModelProductList modelSavedQuestion;
  List<ResultProductList> listData = [];

  Future<List<ResultProductList>> getListFromInternet({required ModelSearch modelSearch}) async {
    Response response = await dio.get(
        "${BaseClass.url}/api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
        options: Options(
            headers: {"X-Access-Token": "82f8ad497b5b70cfed09a68e522a3e94"}));
    log(jsonEncode(response.data).toString());
    try {
      modelSavedQuestion = ModelProductList.fromJson(response.data);
      listData.clear();
      // listData = modelSavedQuestion.results;
      if (listData.isEmpty) {
        listData = modelSavedQuestion.results;
      } else {
        listData.addAll(modelSavedQuestion.results);
      }
      state = listData;
      return state;
    } catch (e) {
      log("@#§123");
      log(e.toString());
      return [];
    }
  }

  //
  // List<ResultProductList> getList() {
  //   return state;
  // }

  /// qidiruv uchun
  ///
  void updateFavorite(String id) {
    for (int i = 0; i < state.length; i++) {
      if (state[i].id.toString() == id.toString()) {
        state[i].isFavorite = !state[i].isFavorite;
      }
    }
  }

  setOrders({required String idOrder}) {
    for (int i = 0; i < state.length; i++) {
      if (state[i].id.toString() == idOrder.toString()) {
        if (state[i].slug != "987654321") {
          /// order uchun parametr yoqligi uchun slug bilan ishlandi. orderga qiymat kelsa shuni olish kerak
          state[i].slug = "987654321";
        } else {
          state[i].slug = "slug";
        }
      }
    }
  }
}
