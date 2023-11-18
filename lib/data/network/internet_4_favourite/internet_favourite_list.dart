import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetGetFavouriteList {
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
  Future<String> getDataFavouriteList() async {
    try {

      var dio = Dio();
      Response response =
          await dio.get("${BaseClass.url}api/v1/web/favorites/",
              options: Options(headers: {
                "Authorization": box.get("token").toString().length > 30
                    ? "Bearer ${box.get("token")}"
                    :"${box.get("ipAddressPhone")}"
              }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(jsonEncode(response.data).toString());
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