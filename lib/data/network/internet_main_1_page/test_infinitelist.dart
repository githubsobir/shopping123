import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetInfiniteList {
  var dio = Dio();
  late Response response;



  Future<String> searchList({required ModelSearch modelSearch}) async {
    try {
      log("${BaseClass.url}/api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}");
      response = await dio.get(
          "${BaseClass.url}/api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
          options: Options(
              headers: {"X-Access-Token": "82f8ad497b5b70cfed09a68e522a3e94"}));
      log("@@@@@@@");
      log(jsonEncode(response.data).toString());
      log("@@@@@@@");
      return jsonEncode(response.data).toString();
    } catch (e) {
      return "Serverda xatolik";
    }
  }
}
