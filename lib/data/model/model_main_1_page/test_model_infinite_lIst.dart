import 'package:flutter_riverpod/flutter_riverpod.dart';

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

        if( state[i].slug  != "987654321") {
          /// order uchun parametr yoqligi uchun slug bilan ishlandi. orderga qiymat kelsa shuni olish kerak
          state[i].slug = "987654321";
        }else{
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
