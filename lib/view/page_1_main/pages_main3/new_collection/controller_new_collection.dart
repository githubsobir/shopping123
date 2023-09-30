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

final setFavourite2 =
    StateNotifierProvider<ModelProductListNotifier, ModelProductList>((ref) {
  return ModelProductListNotifier();
});

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
  var box = Hive.box("online");

  Future<ModelProductList> getData({required ModelSearch modelSearch}) async {
    if (modelSearch.page.toString() == "1" ||
        modelSearch.page.toString() == "null") {
      state = state.copyWith(results: []);
    }

    try {
      Response response = await dio.get(
          "${BaseClass.url}/api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
        options: Options(headers: {"Authorization":"Bearer ${box.get("token")}" }),
      );
      log(response.data.toString());
      modelProductList = ModelProductList.fromJson(response.data);

      // if (modelSearch.page.toString() == "1" ||
      //     modelSearch.page.toString() == "null"
      // ) {
      //   listProduct2.clear();
      //   listProduct2 = modelProductList.results;
      //   state = state.copyWith(results: listProduct2);
      //   return state;
      // } else {
      listProduct2.addAll(modelProductList.results);
      state = state.copyWith(results: listProduct2);
      return state;
      // }
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
    setFavoritesServer(idProduct: id);
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

  setOrder({required String idOrder, required String count, required String colorProduct, required sizeProduct}) {
    List<ResultProductList> updateOrder = [...state.results];
    for (int i = 0; i < updateOrder.length; i++) {
      if (updateOrder[i].id.toString() == idOrder.toString()) {
        if (updateOrder[i].slug != "987654321") {
          /// order uchun parametr yoqligi uchun slug bilan ishlandi. orderga qiymat kelsa shuni olish kerak
          updateOrder[i].slug = "987654321";
          updateOrder[i].count = count;
          updateOrder[i].colorProduct = colorProduct;
          updateOrder[i].sizeProduct = sizeProduct;
        } else {

          updateOrder[i].slug = "slug";
          updateOrder[i].count = "0";
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

  Future setFavoritesServer({required String idProduct}) async {
    try {
      var dio = Dio();
        log(idProduct);
        log(box.get("token").toString());
      Response response = await dio
          .post("https://uzb.technostudio.uz/api/v1/web/favorites/",
          options: Options(headers: {"Authorization":"Bearer ${box.get("token")}" }),
          data: {
            "session_id": box.get("token"),
        "product": idProduct,
      });
      log(jsonEncode(response.data).toString());

    } catch (e) {
      log(e.toString());
      return "";
    }
  }
}
