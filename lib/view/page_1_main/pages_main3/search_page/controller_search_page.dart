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

final cont =
    StateNotifierProvider.autoDispose<ModelSearchListNotifier, ModelProductList>((
  ref,
) {
      return ModelSearchListNotifier();
       });



/// search
class ModelSearchListNotifier extends StateNotifier<ModelProductList> {
  ModelSearchListNotifier() : super(ModelProductList(count: "", next: "", previous: "", results: []));

  var dio = Dio();
  late ModelProductList modelSavedQuestion;
  List<ResultProductList> listData = [];
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
  Future<List<ResultProductList>> getListFromInternet({required ModelSearch modelSearch}) async {



    log("${BaseClass.url}api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}");
    log(BaseClass.getLinkSearch(m: modelSearch));
    Response response = await dio.get(

        "${BaseClass.url}api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
        // options: Options(
        //     headers: {"Authorization": getIpOrToken()})
    );
    log("@34");
    log(jsonEncode(response.data).toString());
    try {
      modelSavedQuestion = ModelProductList.fromJson(response.data);
      listData.clear();
      // listData = modelSavedQuestion.results;
      if (listData.isEmpty) {
        listData = modelSavedQuestion.results;
      } else {
        listData.addAll(modelSavedQuestion.results);
      }
      state = state.copyWith(results: listData);
      return state.results;
    } catch (e) {
      log("@#§123");
      log(e.toString());
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
    updateOrder.addAll(  state.results);
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
  clearData(){
    state.results.clear();
    state = state.copyWith(results: [],previous: "", count: "", next: "");
  }
}
