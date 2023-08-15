import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';


class InternetInfiniteList {
  var dio = Dio();
  late Response response;

  Future<String> getInfiniteList({required String nextPage}) async {
    try {
      response = await dio.get(
          "http://v1api.edusystem.uz/v1/home/saqlanganlar?page=$nextPage&per-page=5",
          options: Options(
              headers: {"X-Access-Token": "82f8ad497b5b70cfed09a68e522a3e94"}));
      // log(jsonEncode(response.data).toString());
      return jsonEncode(response.data).toString();
    } catch (e) {

      return "Serverda xatolik";
    }
  }
}

