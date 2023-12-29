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
    getData(modelSearch: ModelSearch(page: "1"));
  }

  late ModelProductList modelProductList =
      ModelProductList(count: "1", next: "", previous: "", results: []);

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
      state = state.copyWith(
          count: "0",
          next: "0",
          previous: "0",
          results: [], boolGetData: "0", errorText: "");
    }

    try {

      if(state.next.toString() != "null") {
        log("modelProductList.next");
        log(modelProductList.next.toString());
        var response = await dio.get(
          "${BaseClass.url}api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
          options: Options(headers: {"Authorization": getIpOrToken()}),
        );
        modelProductList = ModelProductList.fromJson(response.data);

        listProduct2.addAll(modelProductList.results);
        state = state.copyWith(
            results: listProduct2,
            next: modelProductList.next,
            count: modelProductList.count,
            previous: modelProductList.previous,
            errorText: "",
            boolGetData: "1");
      }

      return state;
    } on DioException catch (e) {
      try{
        if (e.response!.statusCode.toString() == "404" &&
            int.parse(modelSearch.page.toString()) > 1) {
          state = state.copyWith(
              previous: "999",
              next: "999",
              count: "9999",
              results: listProduct2,
              errorText: e.response!.statusCode.toString(),
              boolGetData: "1");
        } else {
          state = state.copyWith(
              previous: "999",
              next: "999",
              count: "9999",
              results: listProduct2,
              errorText: e.error.toString(),
              boolGetData: "2");
        }
      }catch(e2){

        state = state.copyWith(
            previous: "999",
            next: "999",
            count: "9999",
            results: listProduct2,
            errorText: e.error.toString(),
            boolGetData: "2");
      }

      return ModelProductList(
          count: "",
          next: "",
          previous: "",
          boolGetData: "2",
          errorText: e.error.toString(),
          results: []);
    }
  }

  updateFavorite(String id) {
    List<ResultProductList> updateFav = [...state.results];
    setFavoritesServer(idProduct: id);
    for (int i = 0; i < updateFav.length; i++) {
      if (updateFav[i].id.toString() == id.toString()) {
        updateFav[i].isFavorite = !updateFav[i].isFavorite;
        state = state.copyWith(
          results: updateFav,
        );
      }
    }
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
          updateOrder[i].isCart = false;
        } else {
          updateOrder[i].isCart = true;
        }
      }
    }
    state = state.copyWith(results: updateOrder);
    return state;
  }

  /// layklarni serverga yuborish qo'shish
  Future setFavoritesServer({required String idProduct}) async {
    try {
      Response response = await dio.post(
          "${BaseClass.url}api/v1/web/favorites/",
          options: Options(headers: {"Authorization": getIpOrToken()}),
          data: {
            "session_id": box.get("ipAddressPhone").toString(),
            "product": idProduct,
          });
      log("serverga yuborildi !!!");
      log(response.data.toString());
    } catch (e) {
      log(e.toString());
      return "";
    }
  }
}
