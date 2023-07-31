import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shopping/data/model/model_2_category/model_category.dart';

class InternetMainCategory {

  Future<ModelCategoryGet> getCategory() async {
    var dio = Dio();
    Response response;
    response = await dio.get("https://api.uzbekbazar.exadot.io/api/v1/web/categories/");
    log(jsonEncode(response.data).toString());
    return ModelCategoryGet.fromJson(response.data);
  }
}
