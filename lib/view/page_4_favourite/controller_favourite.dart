import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/network/internet_4_favourite/internet_favourite_list.dart';

final getFavouriteList =
    StateNotifierProvider<FavoriteStateNotifier, ModelFavouriteStateNotifier>(
        (ref) => FavoriteStateNotifier());

final boolGetDataAction = StateProvider<bool>((ref) => false);

class FavoriteStateNotifier extends StateNotifier<ModelFavouriteStateNotifier> {
  FavoriteStateNotifier()
      : super(ModelFavouriteStateNotifier(
            next: "", previous: "", count: "", results: [])) {
    getFavouriteListFirst();
  }

  InternetGetFavouriteList getFavouriteList = InternetGetFavouriteList();

  Future getFavouriteListFirst() async {
    try {
      log("123");
      state = state.copyWith("", "", "", false, []);
      String dataFavourite = await getFavouriteList.getDataFavouriteList();

      ModelFavouriteStateNotifier modelFavouriteStateNotifier =
          ModelFavouriteStateNotifier.fromJson(jsonDecode(dataFavourite));
      state = state.copyWith(
          modelFavouriteStateNotifier.count.toString(),
          modelFavouriteStateNotifier.next.toString(),
          modelFavouriteStateNotifier.previous.toString(),
          true,
          modelFavouriteStateNotifier.results);
      log("@@@");
      log(state.results.length.toString());
      log(state.results[0].product.toString());
      log("@@@");
    } catch (e) {
      log(e.toString());
    }
  }

  setFavouriteList({required ResultModelNotifier resultModelNotifier}) {
    List<ResultModelNotifier> listResult = [];
    log(resultModelNotifier.isActive.toString());
    listResult = state.results;
    log(resultModelNotifier.isActive.toString());
    log("message controller favourite");
    if (!resultModelNotifier.isActive) {
      listResult.removeWhere((element) => element.id == resultModelNotifier.id);
    } else {
      listResult.add(resultModelNotifier);
    }
    state = state.copyWith(
        state.count, state.next, state.previous, true, listResult);
  }
}

class ModelFavouriteStateNotifier {
  dynamic count;
  dynamic next;
  dynamic previous;
  dynamic boolDownloadCheck1;

  List<ResultModelNotifier> results;

  ModelFavouriteStateNotifier({
    this.count,
    this.next,
    this.previous,
    required this.results,
    this.boolDownloadCheck1,
  });

  ModelFavouriteStateNotifier copyWith(
    dynamic count,
    dynamic next,
    dynamic previous,
    dynamic boolDownloadCheck1,
    List<ResultModelNotifier> results,
  ) {
    return ModelFavouriteStateNotifier(
        count: count,
        next: next,
        previous: previous,
        boolDownloadCheck1: boolDownloadCheck1,
        results: results);
  }

  factory ModelFavouriteStateNotifier.fromJson(Map<String, dynamic> json) =>
      ModelFavouriteStateNotifier(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<ResultModelNotifier>.from(
            json["results"].map((x) => ResultModelNotifier.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ResultModelNotifier {
  dynamic id;
  Product product;
  dynamic updatedAt;
  dynamic createdAt;
  dynamic sessionId;
  dynamic isActive;
  dynamic user;

  ResultModelNotifier({
    this.id,
    required this.product,
    this.updatedAt,
    this.createdAt,
    this.sessionId,
    this.isActive,
    this.user,
  });

  factory ResultModelNotifier.fromJson(Map<String, dynamic> json) =>
      ResultModelNotifier(
        id: json["id"],
        product: Product.fromJson(json["product"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        sessionId: json["session_id"],
        isActive: json["is_active"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "session_id": sessionId,
        "is_active": isActive,
        "user": user,
      };
}

class Product {
  dynamic id;
  dynamic name;
  dynamic price;
  dynamic photo;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.photo,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "photo": photo,
      };
}
