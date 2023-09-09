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
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
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
  bool isFavorite;
  dynamic photo;
  dynamic rating;

  ResultProductList({
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

  ResultProductList copyWith({
    dynamic id,
    dynamic name,
    dynamic slug,
    dynamic price,
    dynamic discount,
    dynamic newPrice,
    dynamic gender,
    dynamic type,
    dynamic season,
    dynamic material,
    dynamic brand,
    dynamic category,
    dynamic isFavorite,
    dynamic photo,
    dynamic rating,
  }) {
    return ResultProductList(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        newPrice: newPrice ?? this.newPrice,
        gender: gender ?? this.gender,
        type: type ?? this.type,
        season: season ?? this.season,
        material: material ?? this.material,
        brand: brand ?? this.brand,
        category: category ?? this.category,
        isFavorite: isFavorite ?? this.isFavorite,
        photo: photo ?? this.photo,
        rating: rating ?? this.rating);
  }

  factory ResultProductList.fromJson(Map<String, dynamic> json) =>
      ResultProductList(
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
        photo: json["photo"],
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

/// product is favourite, basket-karzinka
class ModelProductListNotifier extends StateNotifier<List<ResultProductList>> {
  // List<ResultProductList> listResultProductList;

  ModelProductListNotifier(super.state);

  void updateFavorite(String id) {
    for (int i = 0; i < state.length; i++) {
      if (state[i].id.toString() == id.toString()) {
        state[i].isFavorite = !state[i].isFavorite;
      }
    }
  }

  getFavorite() {
    List<ResultProductList> list = [];
    for (int i = 0; i < state.length; i++) {
      if (state[i].isFavorite) {
        list.add(state[i]);
      }
    }
    return list;
  }

  setOrder({required String idOrder}) {
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

  getOrder() {
    List<ResultProductList> list = [];
    for (int i = 0; i < state.length; i++) {
      if (state[i].slug.toString() == "987654321") {
        list.add(state[i]);
      }
    }
    return list;
  }
}

/// search
class ModelSearchListNotifier extends StateNotifier<List<ResultProductList>> {
  ModelSearchListNotifier() : super([]);
  var dio = Dio();
  late ModelProductList modelSavedQuestion;
  List<ResultProductList> listData = [];

  Future getListFromInternet({required ModelSearch modelSearch}) async {
    Response response = await dio.get(
        "${BaseUrl.url}/api/v1/web/products/?${getLinkSearch(m: modelSearch)}",
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
    } catch (e) {
      log("@#§123");
      log(e.toString());
    }
  }

  List<ResultProductList> getList() {
    return state;
  }

  String getLinkSearch({required ModelSearch m}) {
    String data = "";
    try {
      if (m.minPrice.toString() != "null" && m.minPrice.toString().isNotEmpty) {
        data = "min_price=${m.minPrice}";
      }
      if (m.maxPrice.toString() != "null" && m.maxPrice.toString().isNotEmpty) {
        data = "max_price=${m.maxPrice}";
      }
      if (m.price.toString() != "null" && m.price.toString().isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&price=${m.price}";
        } else {
          data = "price=${m.price}";
        }
      }
      if (m.organization.toString() != "null" &&
          m.organization.toString().isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&organization=${m.organization}";
        } else {
          data = "organization=${m.organization}";
        }
      }
      if (m.brand.toString() != "null" && m.brand.toString().isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&brand=${m.brand}";
        } else {
          data = "brand=${m.brand}";
        }
      }
      if (m.category.toString() != "null" && m.category.toString().isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&category=${m.category}";
        } else {
          data = "category=${m.category}";
        }
      }
      if (m.categorySlug.toString() != "null" &&
          m.categorySlug.toString().isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&category_slug=${m.categorySlug}";
        } else {
          data = "category_slug=${m.categorySlug}";
        }
      }
      if (m.material.toString() != "null" && m.material.toString().isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&material=${m.material}";
        } else {
          data = "material=${m.material}";
        }
      }
      if (m.color.toString() != "null" && m.color.toString().isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&color=${m.color}";
        } else {
          data = "color=${m.color}";
        }
      }
      if (m.size.toString() != "null" && m.size.toString().isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&size=${m.size}";
        } else {
          data = "size=${m.size}";
        }
      }
      if (m.type.toString() != "null" && m.type.toString().isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&type=${m.type}";
        } else {
          data = "type=${m.type}";
        }
      }
      if (m.season.toString() != "null" && m.season.toString().isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&season=${m.season}";
        } else {
          data = "season=${m.season}";
        }
      }
      if (m.gender.toString() != "null" && m.gender.toString().isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&gender=${m.gender}";
        } else {
          data = "gender=${m.gender}";
        }
      }
      if (m.search.toString() != "null" && m.search.toString().isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&search=${m.search}";
        } else {
          data = "search=${m.search}";
        }
      }
      if (m.ordering.toString() != "null" && m.ordering.toString().isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&ordering=${m.ordering}";
        } else {
          data = "ordering=${m.ordering}";
        }
      }
      if (m.page.toString() != "null" && m.page.toString().isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&page=${m.page}";
        } else {
          data = "page=${m.page}";
        }
      }
      if (m.pageSize.toString() != "null" && m.pageSize.toString().isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&page_size=${m.pageSize}";
        } else {
          data = "page_size=${m.pageSize}";
        }
      }
      if (m.sessionId.toString() != "null" &&
          m.sessionId.toString().isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&session_id=${m.sessionId}";
        } else {
          data = "session_id=${m.sessionId}";
        }
      }
      if (m.lang.toString() != "null" && m.lang.toString().isNotEmpty) {
        if (data.isNotEmpty) {
          data = "$data&lang=${m.lang}";
        } else {
          data = "lang=${m.lang}";
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return data;
  }
}
