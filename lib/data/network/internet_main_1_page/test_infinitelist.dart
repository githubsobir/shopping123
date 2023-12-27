import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
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
              headers: {"X-Access-Token": getIpOrToken()}));
      // log("@@@@@@@");
      // log(jsonEncode(response.data).toString());
      // log("@@@@@@@");
      return jsonEncode(response.data).toString();
    } catch (e) {
      return "Serverda xatolik";
    }
  }

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

}

