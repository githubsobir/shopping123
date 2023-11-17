import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/data/network/base_url.dart';

final getAllProductStore = StateNotifierProvider.family<
    ModelGetAllProductStoreNotifier,
    ModelProductList,
    String>((ref, dataSearch) {
  return ModelGetAllProductStoreNotifier(data: dataSearch);
});

/// product is favourite, basket-karzinka
class ModelGetAllProductStoreNotifier extends StateNotifier<ModelProductList> {
  String data;
  ModelGetAllProductStoreNotifier({required this.data})
      : super(ModelProductList(
          count: "",
          next: "",
          previous: "",
          results: [],
        )) {
    getListData(modelSearch: ModelSearch(organization: data));
  }

  var dio = Dio();
  ModelProductList modelProductList = ModelProductList(
    count: "",
    next: "",
    previous: "",
    results: [],
  );

  Future<List<ResultProductList>> getListData(
      {required ModelSearch modelSearch}) async {
    try {
      Response response = await dio.get(
        "${BaseClass.url}api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
        // options: Options(
        //     headers: {"X-Access-Token": "82f8ad497b5b70cfed09a68e522a3e94"})
      );
      modelProductList = ModelProductList.fromJson(response.data);
      state = state.copyWith(results: modelProductList.results);
      return state.results;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
