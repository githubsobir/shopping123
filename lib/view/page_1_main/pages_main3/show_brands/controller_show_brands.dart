import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/data/network/base_url.dart';

final showBrands =
    StateNotifierProvider.autoDispose<ShowBrandsNotifier, ModelProductList>(
        (ref) => ShowBrandsNotifier());

class ShowBrandsNotifier extends StateNotifier<ModelProductList> {
  var box = Hive.box("online");

  ShowBrandsNotifier()
      : super(
            ModelProductList(count: "", next: "", previous: "", results: [])) {
    getDataBrand(modelSearch: ModelSearch(brand: box.get("brand")));
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

  ModelProductList modelProductList =
      ModelProductList(count: "", next: "456", previous: "123", results: []);

  Future<ModelProductList> getDataBrand(
      {required ModelSearch modelSearch}) async {
    var dio = Dio();
    List<ResultProductList> listProduct2 = [];

    try {
      if (modelSearch.page.toString() == "1" ||
          modelSearch.page.toString() == "null") {
        state = state.copyWith(results: []);
      }
      Response response = await dio.get(
          "${BaseClass.url}api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
          options: Options(
              headers: {"Authorization": getIpOrToken()}));
      log(jsonEncode(response.data).toString());
      modelProductList = ModelProductList.fromJson(response.data);
      // log(jsonEncode(modelProductList).toString());
      if (modelSearch.page.toString() == "1" ||
          modelSearch.page.toString() == "null") {
        listProduct2.clear();
        listProduct2 = modelProductList.results;
        state = state.copyWith(results: modelProductList.results);
        return state;
      } else {
        listProduct2.addAll(modelProductList.results);
        state = state.copyWith(results: listProduct2);
        return state;
      }
    } catch (e) {
      log("###");
      log(e.toString());
      return ModelProductList(count: "", next: "", previous: "", results: []);
    }
  }

  void updateFavoriteBrand(String id) {
    List<ResultProductList> listUpFavBrand = [];
    listUpFavBrand.addAll(state.results);
    log(jsonEncode(state));

    for (int i = 0; i < listUpFavBrand.length; i++) {
      if (listUpFavBrand[i].id.toString() == id.toString()) {
        listUpFavBrand[i].isFavorite = !listUpFavBrand[i].isFavorite;
      }
    }

    state = state.copyWith(results: listUpFavBrand);
  }

  setOrdersBrand({required String idOrder}) {
    List<ResultProductList> updateOrder = [];
    updateOrder.addAll(state.results);
    log(updateOrder.toString());
    for (int i = 0; i < updateOrder.length; i++) {
      if (updateOrder[i].id.toString() == idOrder) {
        if (!updateOrder[i].isCart) {
          /// order uchun parametr yoqligi uchun slug bilan ishlandi. orderga qiymat kelsa shuni olish kerak
          updateOrder[i].isCart = true;
        } else {
          updateOrder[i].isCart = false;
        }
      }
    }
    state = state.copyWith(results: updateOrder);
  }
}
