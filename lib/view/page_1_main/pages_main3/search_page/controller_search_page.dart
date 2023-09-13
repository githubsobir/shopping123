import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/model_main_search.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
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
    StateNotifierProvider<ModelSearchListNotifier, List<ResultProductList>>((
  ref,
) {
      return ModelSearchListNotifier();
       });

