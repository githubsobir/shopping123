import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping/data/model/model_main_1_page/model_banners.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/data/network/base_url.dart';
import 'package:shopping/data/network/internet_main_1_page/internet_new_collections/new_collections.dart';
import 'package:shopping/data/network/internet_main_1_page/test_infinitelist.dart';

final apiProviderNewCollection = Provider<InternetMainNewCollectionsBody>(
    (ref) => InternetMainNewCollectionsBody());

final getDataNewCollection = FutureProvider<ModelBanners>((ref) {
  return ref.read(apiProviderNewCollection).getMainNewCollections();
});

final apiProviderInfiniteList =
    Provider<InternetInfiniteList>((ref) => InternetInfiniteList());

final setFavourite2 = StateNotifierProvider.autoDispose<
    ModelProductListNotifier, ModelProductList>((ref) {
  return ModelProductListNotifier();
});

/// product is favourite, basket-karzinka
class ModelProductListNotifier extends StateNotifier<ModelProductList> {
  ModelProductListNotifier()
      : super(
            ModelProductList(count: "1", next: "", previous: "", results: [])) {
    getData(modelSearch: ModelSearch());
  }
  ModelProductListNotifier copyWith(dynamic count,
      ModelProductList modelProductList) {
    return ModelProductListNotifier(
       );
  }



  late ModelProductList modelProductList =
      ModelProductList(count: "1", next: "", previous: "", results: []);
  List<ResultProductList> listProducts = [];
  List<ResultProductList> listProduct2 = [];
  var dio = Dio();
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

  Future<ModelProductList> getData({required ModelSearch modelSearch}) async {
    if (modelSearch.page.toString() == "1" ||
        modelSearch.page.toString() == "null") {
      state = state.copyWith(results: []);
    }
    Response response;
    try {
      response = await dio.get(
        "https://uzbazar.husanibragimov.uz/api/v1/web/products/",
        options: Options(headers: {"Authorization": getIpOrToken()}),
      );
      modelProductList = ModelProductList.fromJson(response.data);
      listProduct2.addAll(modelProductList.results);
      state = state.copyWith(results: listProduct2);
      log(jsonEncode(response.data).toString());
      return state;
    } catch (e) {
      return ModelProductList(count: "", next: "", previous: "", results: []);
    }
  }

  List<ResultProductList> getList() {
    return state.results;
  }

  updateFavorite(String id) {
    List<ResultProductList> updateFav = [...state.results];
    setFavoritesServer(idProduct: id);
    for (int i = 0; i < updateFav.length; i++) {
      if (updateFav[i].id.toString() == id.toString()) {
        log(updateFav[i].isFavorite.toString());
        updateFav[i].isFavorite = !updateFav[i].isFavorite;
        state = state.copyWith(results: updateFav);

        // state.results = updateFav;
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

  setOrder(
      {required String idOrder,
      required String count,
      required String colorProduct,
      required sizeProduct}) {
    List<ResultProductList> updateOrder = [...state.results];
    for (int i = 0; i < updateOrder.length; i++) {
      if (updateOrder[i].id.toString() == idOrder.toString()) {
        if (updateOrder[i].isCart) {
          /// order uchun parametr yoqligi uchun slug bilan ishlandi. orderga qiymat kelsa shuni olish kerak
          updateOrder[i].isCart = false;
          // updateOrder[i]. = colorProduct;
          // updateOrder[i].size = sizeProduct;
        } else {
          updateOrder[i].isCart = true;
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
      if (list[i].isCart) {
        // list.add(state.results[i]);
        // state = state.copyWith(results: )
      }
    }
    return state.results;
  }

  /// layklarni serverga yuborish qo'shish
  Future setFavoritesServer({required String idProduct}) async {
    try {
      var dio = Dio();
      log(getIpOrToken().toString());
      log(idProduct.toString());
      Response response = await dio.post(
          "${BaseClass.url}api/v1/web/favorites/",
          options: Options(headers: {"Authorization": getIpOrToken()}),
          data: {
            "session_id": getIpOrTokenWithOutBearer(),
            "product": idProduct,
          });

      log(response.data.toString());
    } catch (e) {
      log(e.toString());
      return "";
    }
  }

  /// karzinkaga maxsulot qo'shish
  Future setCartServer(
      {required String idProduct,
      required String colorId,
      required String sizeId,
      required String materialId}) async {
    try {
      var dio = Dio();

      Response response = await dio.post(
          "${BaseClass.url}api/v1/web/carts/",
          options: Options(headers: {"Authorization": getIpOrToken()}),
          data: {
            "session_id": getIpOrTokenWithOutBearer(),
            "product": idProduct,
            "product_variable": colorId,
            "size": sizeId,
            "material": sizeId,
          });
      log(jsonEncode(response.data).toString());
    } catch (e) {
      log(e.toString());
      return "";
    }
  }
}
