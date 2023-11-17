import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:shopping/data/model/model_2_category/model_category.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetMainCategory {

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
  Future<ModelCategoryGet> getCategory() async {
    var dio = Dio();
    Response response;
    response = await dio.get("${BaseClass.url}api/v1/web/categories/");
    return ModelCategoryGet.fromJson(response.data);
  }

  Future<ModelProductList> getCategoryOpen(
      {required ModelSearch modelSearch}) async {
    var dio = Dio();
    Response response;
    try {
      response = await dio.get(
          "${BaseClass.url}/api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
          options: Options(
              headers: {"X-Access-Token": getIpOrToken}));
      log(jsonEncode(modelSearch).toString());
      log(jsonEncode(response.data).toString());
      return ModelProductList.fromJson(response.data);
    } catch (e) {
      return ModelProductList(
          results: [], previous: "", count: "", next: "");
    }
  }
}
