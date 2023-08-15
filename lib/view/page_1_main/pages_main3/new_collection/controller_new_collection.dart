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

List<DatumSavedQuestion> listData = [];
final getDataInfinitiList =
FutureProvider.family<List<DatumSavedQuestion>, String>(
        (ref, dataString) async {

      String data = await ref
          .read(apiProviderInfiniteList)
          .getInfiniteList(nextPage: dataString);
      log(data);
      ModelSavedQuestion modelSavedQuestion =
      ModelSavedQuestion.fromJson(jsonDecode(data));
      log(jsonEncode(modelSavedQuestion).toString());

      if (listData.isEmpty) {
        listData = modelSavedQuestion.data.data;
      } else {
        listData.addAll(modelSavedQuestion.data.data);
      }

      return listData;
    });
