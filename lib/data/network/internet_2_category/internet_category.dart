import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shopping/data/model/model_2_category/model_category.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetMainCategory {
  Future<ModelCategoryGet> getCategory() async {
    var dio = Dio();
    Response response;
    response = await dio.get("${BaseClass.url}/api/v1/web/categories/");
    log(jsonEncode(response.data).toString());
    return ModelCategoryGet.fromJson(response.data);
  }

  Future<ModelProductListForCategory> getCategoryOpen(
      {required ModelSearch modelSearch}) async {
    var dio = Dio();
    Response response;
    try {
      response = await dio.get(
          "${BaseClass.url}/api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
          options: Options(
              headers: {"X-Access-Token": "82f8ad497b5b70cfed09a68e522a3e94"}));
      log(jsonEncode(modelSearch).toString());
      log(jsonEncode(response.data).toString());
      return ModelProductListForCategory.fromJson(response.data);
    } catch (e) {
      return ModelProductListForCategory(
          results: [], previous: "", count: "", next: "");
    }
  }
}
