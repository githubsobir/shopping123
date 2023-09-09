import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/new_collection/new_collection_model.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/data/network/internet_main_1_page/internet_new_collections/new_collections.dart';
import 'package:shopping/data/network/internet_main_1_page/test_infinitelist.dart';

final apiProviderNewCollection = Provider<InternetMainNewCollectionsBody>(
    (ref) => InternetMainNewCollectionsBody());

final getDataNewCollection = FutureProvider<ModelMainNewCollections>((ref) {
  return ref.read(apiProviderNewCollection).getMainNewCollections();
});

final apiProviderInfiniteList =
    Provider<InternetInfiniteList>((ref) => InternetInfiniteList());

List<ResultProductList> listData = [];
late ModelProductList modelSavedQuestion;

final getDataInfinitiList = FutureProvider.family
    .autoDispose<List<ResultProductList>, String>((ref, numberPage) async {
  String data = await ref
      .read(apiProviderInfiniteList)
      .getInfiniteList(nextPage: numberPage);
  try {
    modelSavedQuestion = ModelProductList.fromJson(jsonDecode(data));
  } catch (e) {
    log(e.toString());
  }
  if (listData.isEmpty) {
    listData = modelSavedQuestion.results;
  } else {
    listData.addAll(modelSavedQuestion.results);
  }

  return listData;
});

final getList = StateProvider<List<ResultProductList>>((ref) => listData);

final setFavourite2 =
    StateNotifierProvider<ModelProductListNotifier, List<ResultProductList>>(
        (ref) {
  return ModelProductListNotifier(listData);
});
