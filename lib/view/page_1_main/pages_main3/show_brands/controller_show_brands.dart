import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/data/network/base_url.dart';

// final showBrands = StateNotifierProvider.family<
//     ShowBrandsNotifier,
//     ModelProductList,
//     ModelSearch>((ref, m) => ShowBrandsNotifier(modelSearch: m));

// final getDataBrandFutureProvider =
//     FutureProvider.family<ModelProductList, ModelSearch>((ref, modelSearch) async {
//
// });

// class ShowBrandsNotifier extends StateNotifier<ModelProductList> {
//   ModelSearch modelSearch;
//
//   ShowBrandsNotifier({required this.modelSearch})
// // ShowBrandsNotifier()
//       : super(
//             ModelProductList(count: "", next: "", previous: "", results: [])) {
//     getDataBrand(modelSearch: modelSearch);
//   }
//
//   ModelProductList modelProductList =
//       ModelProductList(count: "", next: "", previous: "", results: []);
//
//   Future<ModelProductList> getDataBrand(
//       {required ModelSearch modelSearch}) async {
//     var dio = Dio();
//     List<ResultProductList> listProduct2 = [];
//
//     try {
//       if (modelSearch.page.toString() == "1" ||
//           modelSearch.page.toString() == "null") {
//         state = state.copyWith(results: []);
//       }
//       Response response = await dio.get(
//           "${BaseClass.url}/api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
//           options: Options(
//               headers: {"X-Access-Token": "82f8ad497b5b70cfed09a68e522a3e94"}));
//
//       modelProductList = ModelProductList.fromJson(response.data);
//       log(jsonEncode(modelProductList).toString());
//       if (modelSearch.page.toString() == "1" ||
//           modelSearch.page.toString() == "null") {
//         listProduct2.clear();
//         listProduct2 = modelProductList.results;
//         state = state.copyWith(results: listProduct2);
//
//         return state;
//       } else {
//         listProduct2.addAll(modelProductList.results);
//         state = state.copyWith(results: listProduct2);
//         return state;
//       }
//     } catch (e) {
//       log("###");
//       log(e.toString());
//       return ModelProductList(count: "", next: "", previous: "", results: []);
//     }
//   }
// }



final futureUserProvider = FutureProvider.family<ModelProductList, String>((ref,s ) async {
  return await HomeController().fetchData(s);
});

class HomeController {
  // String data;
  // HomeController(){
    // fetchData(modelSearch: ModelSearch(brand: data));
  // }
  // ModelSearch modelSearch = ModelSearch();



  Future<ModelProductList> fetchData(String s) async {

    var dio = Dio();
    List<ResultProductList> listProduct2 = [];
    ModelSearch modelSearch = ModelSearch(brand: s);

    if (modelSearch.page.toString() == "1" ||
        modelSearch.page.toString() == "null") {
    }
    Response response = await dio.get(
        "${BaseClass.url}/api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
        options: Options(
            headers: {"X-Access-Token": "82f8ad497b5b70cfed09a68e522a3e94"}));

    ModelProductList modelProductList = ModelProductList.fromJson(response.data);
    log(jsonEncode(modelProductList).toString());
    if (modelSearch.page.toString() == "1" ||
        modelSearch.page.toString() == "null") {
      listProduct2.clear();

      return modelProductList;
    } else {
      return ModelProductList(count: "", next: "", previous: "", results: []);
    }
  }
}