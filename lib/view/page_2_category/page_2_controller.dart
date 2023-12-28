import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_2_category/model_category.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/data/network/internet_2_category/internet_category.dart';

final apiCategory =
    Provider<InternetMainCategory>((ref) => InternetMainCategory());

final getCategoryData1 =
    StateNotifierProvider<CategoryStateNotifier, ModelCategoryGet>(
        (ref) => CategoryStateNotifier());

final getCategoryPage =
    StateNotifierProvider.autoDispose<CategoryNotifier, ModelProductList>(
        (ref) => CategoryNotifier());

class CategoryStateNotifier extends StateNotifier<ModelCategoryGet> {
  CategoryStateNotifier()
      : super(ModelCategoryGet(
            count: 0,
            errorText: "",
            boolDownload: "0",
            next: "",
            previous: "",
            results: [])){
    getDataCategory();
  }

  InternetMainCategory internetMainCategory = InternetMainCategory();

  Future getDataCategory() async {
    try {
      state = state.copyWith("0", "0", "0", "0", "", []);
      ModelCategoryGet modelCategoryGet =
          await internetMainCategory.getCategory();
      state = state.copyWith(modelCategoryGet.count, modelCategoryGet.next,
          modelCategoryGet.previous, "1", "", modelCategoryGet.results);
    } on DioException catch (e) {
      try{
        state = state.copyWith(
            "0", "0", "0", "2", e.error.toString(), []);
      }catch(e){
        state = state.copyWith(
            "0", "0", "0", "2", e.toString(), []);
      }
    }
  }
}
