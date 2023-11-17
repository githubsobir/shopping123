import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetGetBasketList {
  Future<String> getDataBasketList() async {
    try {
      var dio = Dio();
      Response response = await dio.get("${BaseClass.url}/api/v1/web/carts/");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonEncode(response.data).toString();
      } else {
        return jsonEncode(response.data).toString();
      }
    } catch (e) {
      log(e.toString());
      return "error";

    }
  }
}
