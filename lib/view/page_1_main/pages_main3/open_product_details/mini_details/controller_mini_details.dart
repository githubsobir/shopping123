import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping/data/model/model_details/model_details.dart';
import 'package:shopping/data/network/base_url.dart';

/// mini details uchun
final getListSize = StateProvider<List<Size>>((ref) => []);
final getListDetails = StateProvider<List<Variable>>((ref) => []);
final countMiniDetails = StateProvider<int>((ref) => 1);
final selectColorMiniDetails = StateProvider<int>((ref) => -1);
final selectSizeMiniDetails = StateProvider<int>((ref) => -1);
final noSelectColorMiniDetails = StateProvider<int>((ref) => 0);
final noSelectSizeMiniDetails = StateProvider<int>((ref) => 0);
final sizeSelectProduct = StateProvider<String>((ref) => "");
final colorSelectProduct = StateProvider<String>((ref) => "");
final productId = StateProvider<String>((ref) => "");
final sizeId = StateProvider<String>((ref) => "");
final colorId = StateProvider<String>((ref) => "");

final sendServer =
    StateNotifierProvider<MiniDetailsWorkNetwork, ModelMiniDetails>(
        (ref) => MiniDetailsWorkNetwork());

// To parse this JSON data, do
//
//     final modelMiniDeatail = modelMiniDeatailFromJson(jsonString);

class MiniDetailsWorkNetwork extends StateNotifier<ModelMiniDetails> {
  MiniDetailsWorkNetwork()
      : super(ModelMiniDetails(
            id: "",
            updatedAt: "",
            createdAt: "",
            sessionId: "",
            quantity: "",
            product: "",
            productVariable: "",
            size: "",
            user: ""));

  var box = Hive.box("online");

  Future setCartWithProductId({
      required String idProduct,
      required String countProduct,
      required String sizeId,
      required String sizeProduct,
      required String colorProduct,
      required String colorId,
      }) async {
    try {
      log("##1");
      log( idProduct.toString());
      log( box.get("token").toString());

      log("log: ${"${BaseClass.url}api/v1/web/carts"}");
      log("getIpOrToken: : ${getIpOrToken()}");
      log("idProduct: : $idProduct");
      log("countProduct: : $countProduct");
      log("sizeId: : $sizeId");
      log("sizeProduct: : $sizeProduct");
      log("colorProduct: : $colorProduct");
      log("colorId: : $colorId");
      var dio = Dio();
      Response response = await dio.post("${BaseClass.url}api/v1/web/carts/",

          options: Options(headers: {"Authorization":getIpOrToken()}),
          data: {
        "session_id":  box.get("ipAddressPhone").toString(),
        // "quantity": countProduct.toString(),
        "product": idProduct.toString(),
        "product_variable": colorId.toString(),
        "size": sizeId.toString(),
        "user": box.get("userId")
      });
      log("##2");
      log(jsonEncode(response.data).toString());
      if(response.statusCode == 500){
        log("500 777");
      }
    } catch (e) {
      log(e.toString());
    }
  }
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
}

class ModelMiniDetails {
  dynamic id;
  dynamic updatedAt;
  dynamic createdAt;
  dynamic sessionId;
  dynamic quantity;
  dynamic product;
  dynamic productVariable;
  dynamic size;
  dynamic user;

  ModelMiniDetails({
    this.id,
    this.updatedAt,
    this.createdAt,
    this.sessionId,
    this.quantity,
    this.product,
    this.productVariable,
    this.size,
    this.user,
  });

  ModelMiniDetails copyWith(
    dynamic id,
    dynamic updatedAt,
    dynamic createdAt,
    dynamic sessionId,
    dynamic quantity,
    dynamic product,
    dynamic productVariable,
    dynamic size,
    dynamic user,
  ) {
    return ModelMiniDetails(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      sessionId: sessionId ?? this.sessionId,
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
      productVariable: productVariable ?? this.productVariable,
      size: size ?? this.size,
      user: user ?? this.user,
    );
  }

  factory ModelMiniDetails.fromJson(Map<String, dynamic> json) =>
      ModelMiniDetails(
        id: json["id"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
        sessionId: json["session_id"],
        quantity: json["quantity"],
        product: json["product"],
        productVariable: json["product_variable"],
        size: json["size"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "session_id": sessionId,
        "quantity": quantity,
        "product": product,
        "product_variable": productVariable,
        "size": size,
        "user": user,
      };
}
