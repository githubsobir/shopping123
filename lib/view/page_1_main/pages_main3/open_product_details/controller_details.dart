import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_details/model_details.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/data/network/base_url.dart';
import 'package:shopping/data/network/internet_details/internet_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/mini_details/controller_mini_details.dart';

///

final getListDetailsPage = StateProvider<List<Variable>>((ref) => []);
final countMiniDetailsPage = StateProvider<int>((ref) => 1);
final selectColorMiniDetailsPage = StateProvider<int>((ref) => -1);
final selectSizeMiniDetailsPage = StateProvider<int>((ref) => -1);
final noSelectColorMiniDetailsPage = StateProvider<int>((ref) => -1);
final noSelectSizeMiniDetailsPage = StateProvider<int>((ref) => -1);
final sizeSelectProductPage = StateProvider<String>((ref) => "");
final colorSelectProductPage = StateProvider<String>((ref) => "");



///

final apiProviderDetails =
    Provider<InternetDetailsInformation>((ref) => InternetDetailsInformation());

final boolIsFavourite = StateProvider<bool>((ref) => false);

final getDetails = FutureProvider.family<ModelDetails, String>((ref, id) async {
  ModelDetails modelDetails =
      await ref.read(apiProviderDetails).getDetailsInformation(id: id);
  log(jsonEncode(modelDetails.variables).toString());
  ref.read(getListDetails.notifier).state = modelDetails.variables;
  return modelDetails;
});

final getSimilarItem =
    StateNotifierProvider.family<SimilarItemPage, ModelProductList, String>(
        (ref, id) => SimilarItemPage(data: id));

class SimilarItemPage extends StateNotifier<ModelProductList> {
  String data;

  SimilarItemPage({required this.data})
      : super(
            ModelProductList(count: "", next: "", previous: "", results: [])) {
    getListData(modelSearch: ModelSearch(search: data));
  }

  var dio = Dio();
  ModelProductList modelProductList =
      ModelProductList(count: "", next: "", previous: "", results: []);

  Future<List<ResultProductList>> getListData(
      {required ModelSearch modelSearch}) async {
    try {
      Response response = await dio.get(
          "${BaseClass.url}/api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
          options: Options(
              headers: {"X-Access-Token": "82f8ad497b5b70cfed09a68e522a3e94"}));
      modelProductList = ModelProductList.fromJson(response.data);
      state = state.copyWith(results: modelProductList.results);
      return state.results;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
