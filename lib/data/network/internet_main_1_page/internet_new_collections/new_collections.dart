import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping/data/model/model_main_1_page/model_banners.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetMainNewCollectionsBody {

  Future<ModelBanners> getMainNewCollections() async {
    var box = Hive.box("online");
    var dio = Dio();
    Response response;
    log("S001");
    log("${BaseClass.url}/api/v1/web/banners/");
    log(box.get("token").toString());
    response = await dio.get("${BaseClass.url}/api/v1/web/banners/",
    options: Options(headers: {"X-CSRFToken":box.get("token")})
    );
    log(jsonEncode(response.data).toString());
    return ModelBanners.fromJson(response.data);
  }
}
