import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shopping/data/network/base_url.dart';

final getOrder =
    StateNotifierProvider<BasketNotifierState, ModeCartList>((ref) {
  return BasketNotifierState();
});

class BasketNotifierState extends StateNotifier<ModeCartList> {
  BasketNotifierState() : super(ModeCartList(results: [])) {getBasketList();}

  var box = Hive.box("online");

  String getIpOrToken() {
    if (box.get("token").toString().length > 20) {
      return "Bearer ${box.get("token")}";
    } else {
      return box.get("ipAddressPhone").toString();
    }
  }

  String getIpOrTokenWithOutBearer() {
    if (box.get("token").toString().length > 20) {
      return box.get("token");
    } else {
      return box.get("ipAddressPhone").toString();
    }
  }

  Future getBasketList() async {
    try {
      var dio = Dio();
      List<Result> results = [];
      log("${BaseClass.url}api/v1/web/carts/?session_id=${getIpOrTokenWithOutBearer()}");
      Response response = await dio.get(
          "${BaseClass.url}api/v1/web/carts/?session_id=${getIpOrTokenWithOutBearer()}");
      log(jsonEncode(response.data).toString());
      results = (response.data as List).map((e) => Result.fromJson(e)).toList();

      state = state.copyWith(results1: results);
    } catch (e) {
      log(e.toString());
    }
  }
}

/// savatdan o'chirish

class ModeCartList {
  dynamic count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  ModeCartList({
    this.count,
    this.next,
    this.previous,
    required this.results,
  });

  ModeCartList copyWith({
    dynamic count1,
    dynamic next1,
    dynamic previous1,
    required List<Result> results1,
  }) {
    return ModeCartList(
        count: count1, next: next1, previous: previous1, results: results1);
  }

  factory ModeCartList.fromJson(Map<String, dynamic> json) => ModeCartList(
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
  dynamic id;
  dynamic product;
  dynamic size;
  dynamic material;
  dynamic updatedAt;
  dynamic createdAt;
  dynamic quantity;

  Result({
    this.id,
    this.product,
    this.size,
    this.material,
    this.updatedAt,
    this.createdAt,
    this.quantity,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        product: Product.fromJson(json["product"]),
        size: json["size"] == null ? null : Size.fromJson(json["size"]),
        material: json["material"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
        "size": size?.toJson(),
        "material": material,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "quantity": quantity,
      };
}

class Product {
  dynamic id;
  dynamic name;
  dynamic price;
  dynamic photo;
  Color? color;

  Product({
    this.id,
    this.name,
    this.price,
    this.photo,
    required this.color,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        photo: json["photo"],
        color: json["color"] == null ? null : Color.fromJson(json["color"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "photo": photo,
        "color": color?.toJson(),
      };
}

class Color {
  dynamic id;
  dynamic code;
  dynamic name;

  Color({
    this.id,
    this.code,
    this.name,
  });

  factory Color.fromJson(Map<String, dynamic> json) => Color(
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

class Size {
  dynamic id;
  dynamic name;

  Size({
    this.id,
    this.name,
  });

  factory Size.fromJson(Map<String, dynamic> json) => Size(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
