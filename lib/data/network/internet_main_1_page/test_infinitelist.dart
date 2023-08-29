import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shopping/data/network/base_url.dart';


class InternetInfiniteList {
  var dio = Dio();
  late Response response;

  Future<String> getInfiniteList({required String nextPage}) async {
    try {
      response = await dio.get(
          "${BaseUrl.url}/api/v1/web/products/?page=$nextPage",
          options: Options(
              headers: {"X-Access-Token": "82f8ad497b5b70cfed09a68e522a3e94"}));
      return jsonEncode(response.data).toString();
    } catch (e) {

      return "Serverda xatolik";
    }
  }
}

