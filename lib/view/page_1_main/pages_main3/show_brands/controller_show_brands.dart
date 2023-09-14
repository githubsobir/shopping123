import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/data/network/base_url.dart';

final showBrands = StateNotifierProvider.family<
    ShowBrandsNotifier,
    ModelProductList,
    ModelSearch>((ref, m) => ShowBrandsNotifier(modelSearch: m));


class ShowBrandsNotifier extends StateNotifier<ModelProductList> {
  ModelSearch modelSearch;

  ShowBrandsNotifier({required this.modelSearch})
      : super(
            ModelProductList(count: "", next: "", previous: "", results: []))
  {
    // log(jsonEncode(modelSearch).toString());
    // if(modelSearch.brand == "-1") {
      getDataBrand(modelSearch: modelSearch);
    // }
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
        // state = state.copyWith(results: []);
      }
      Response response = await dio.get(
          "${BaseClass.url}/api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
          options: Options(
              headers: {"X-Access-Token": "82f8ad497b5b70cfed09a68e522a3e94"}));
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
    // listUpFavBrand.clear();
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
    for (int i = 0; i < state.results.length; i++) {
      if (state.results[i].id.toString() == idOrder.toString()) {
        if (state.results[i].slug != "987654321") {
          /// order uchun parametr yoqligi uchun slug bilan ishlandi. orderga qiymat kelsa shuni olish kerak
          state.results[i].slug = "987654321";
        } else {
          state.results[i].slug = "slug";
        }
      }
    }
  }
}

