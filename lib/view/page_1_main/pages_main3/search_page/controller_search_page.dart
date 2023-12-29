import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shopping/data/model/model_main_1_page/model_main_search.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/data/network/base_url.dart';
import 'package:shopping/data/network/internet_main_1_page/internet_search.dart';
import 'package:shopping/data/network/internet_main_1_page/test_infinitelist.dart';

final apiMainSearchBrands =
    Provider<InternetMainSearch>((ref) => InternetMainSearch());

final getMainSearchBrandData = FutureProvider<ModelMainSearchBrend>((ref) {
  return ref.read(apiMainSearchBrands).getMainSearchBrand();
});

final textSearch = StateProvider<String>((ref) => "");

final apiProviderSearch =
    Provider<InternetInfiniteList>((ref) => InternetInfiniteList());

List<ResultProductList> listData = [];
late ModelProductList modelSavedQuestion;

/// birinchi kirishda maxsus kalit so'z bilan tekshiraman
final getDataSearch = FutureProvider.family
    .autoDispose<List<ResultProductList>, ModelSearch>(
        (ref, modelSearch) async {
  // log("@@@1");
  if (modelSearch.search.toString() != "@@@1") {
    String data =
        await ref.read(apiProviderSearch).searchList(modelSearch: modelSearch);
    // log(data.toString());
    try {
      modelSavedQuestion = ModelProductList.fromJson(jsonDecode(data));
      listData.clear();
      // listData = modelSavedQuestion.results;
      if (listData.isEmpty) {
        listData = modelSavedQuestion.results;
      } else {
        listData.addAll(modelSavedQuestion.results);
      }
    } catch (e) {
      log("@#§123");
      log(e.toString());
    }
  } else {}

  return listData;
});

final cont = StateNotifierProvider.autoDispose<ModelSearchListNotifier,
    ModelProductList>((
  ref,
) {
  return ModelSearchListNotifier();
});

/// search
class ModelSearchListNotifier extends StateNotifier<ModelProductList> {
  ModelSearchListNotifier()
      : super(ModelProductList(boolGetData: "1", errorText: "" , count: "", next: "", previous: "", results: []));

  var dio = Dio();
  late ModelProductList modelSavedQuestion;
  List<ResultProductList> listData = [];
  var box = Hive.box("online");

  Future<List<ResultProductList>> getListFromInternet(
      {required ModelSearch modelSearch}) async {
    state = state.copyWith(
        previous: "",
        next: "",
        count: "0",
        boolGetData: "0",
        errorText: "",
        results: []);
    try {
    Response response = await dio.get(
      "${BaseClass.url}api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
    );

      modelSavedQuestion = ModelProductList.fromJson(response.data);
      listData.clear();
      if (listData.isEmpty) {
        listData = modelSavedQuestion.results;
      } else {
        listData.addAll(modelSavedQuestion.results);
      }
      state = state.copyWith(
          previous: modelSavedQuestion.previous,
          next: modelSavedQuestion.next,
          count: modelSavedQuestion.count,
          boolGetData: "1",
          errorText: "",
          results: listData);

      return state.results;
    }  on DioException catch (e) {
     try {
        state = state.copyWith(
            previous: "",
            next: "",
            count: "",
            boolGetData: "2",
            errorText: e.message,
            results: []);
      }catch(e){
       state = state.copyWith(
           previous: "",
           next: "",
           count: "",
           boolGetData: "2",
           errorText: e.toString(),
           results: []);
     }

      return [];
    }
  }

  /// qidiruv uchun
  ///
  void updateFavorite(String id) {
    List<ResultProductList> updateFav = [...state.results];
    for (int i = 0; i < updateFav.length; i++) {
      if (updateFav[i].id.toString() == id.toString()) {
        updateFav[i].isFavorite = !updateFav[i].isFavorite;

        state = state.copyWith(results: updateFav);

        // state.results = updateFav;
        log(state.results[i].isFavorite.toString());
      }
    }
  }

  setOrders({required String idOrder}) {
    List<ResultProductList> updateOrder = [];
    updateOrder.addAll(state.results);
    log(updateOrder.toString());
    for (int i = 0; i < updateOrder.length; i++) {
      if (updateOrder[i].id.toString() == idOrder) {
        if (updateOrder[i].isCart) {
          /// order uchun parametr yoqligi uchun slug bilan ishlandi. orderga qiymat kelsa shuni olish kerak
          updateOrder[i].isCart = false;
        } else {
          updateOrder[i].isCart = true;
        }
      }
    }
    state = state.copyWith(results: updateOrder);
    return state;
  }

  clearData() {
    state.results.clear();
    state = state.copyWith(results: [], previous: "", count: "", next: "");
  }
}
