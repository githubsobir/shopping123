import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';

final getOrder =
StateNotifierProvider<ModelProductListNotifier, ModelProductList>(
        (ref) {
      return ModelProductListNotifier();
    });


/// savatdan o'chirish

// To parse this JSON data, do
//
//     final modelCartListNotifier = modelCartListNotifierFromJson(jsonString);


class ModelCartListNotifier {
  dynamic count;
  dynamic next;
  dynamic previous;
  dynamic boolCartListDataDownload;
  List<ResultCartListNotifier> results;

  ModelCartListNotifier({
    this.count,
    this.next,
    this.previous,
    this.boolCartListDataDownload,
    required this.results,
  });

  ModelCartListNotifier copyWith(dynamic count,
      dynamic next1,
      dynamic previous1,
      dynamic boolCartListDataDownload1,
      List<ResultCartListNotifier> results) {
    return ModelCartListNotifier(
        next:next1??next,
        previous:previous1??previous,
        boolCartListDataDownload:boolCartListDataDownload1??boolCartListDataDownload,
        results: results);
  }


  factory ModelCartListNotifier.fromJson(Map<String, dynamic> json) =>
      ModelCartListNotifier(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        boolCartListDataDownload: json["boolCartListDataDownload"],
        results: List<ResultCartListNotifier>.from(
            json["results"].map((x) => ResultCartListNotifier.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "count": count,
        "next": next,
        "previous": previous,
        "boolCartListDataDownload": boolCartListDataDownload,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ResultCartListNotifier {
  dynamic id;
  Product product;
  dynamic size;
  dynamic material;
  dynamic updatedAt;
  dynamic createdAt;
  dynamic quantity;

  ResultCartListNotifier({
    this.id,
    required this.product,
    this.size,
    this.material,
    this.updatedAt,
    this.createdAt,
    this.quantity,
  });

  factory ResultCartListNotifier.fromJson(Map<String, dynamic> json) =>
      ResultCartListNotifier(
        id: json["id"],
        product: Product.fromJson(json["product"]),
        size: json["size"],
        material: json["material"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "product": product.toJson(),
        "size": size,
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
  dynamic color;

  Product({
    this.id,
    this.name,
    this.price,
    this.photo,
    this.color,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        photo: json["photo"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "price": price,
        "photo": photo,
        "color": color,
      };
}
