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


      var dio = Dio();
      Response response =
          await dio.get("${BaseClass.url}api/v1/web/favorites",
              options: Options(headers: {
                "Authorization": box.get("token").toString().length > 30
                    ? "Bearer ${box.get("token")}"
                    :"${box.get("ipAddressPhone")}"
              }));
      log("${BaseClass.url}api/v1/web/favorites");
        return jsonEncode(response.data).toString();
  }
}
