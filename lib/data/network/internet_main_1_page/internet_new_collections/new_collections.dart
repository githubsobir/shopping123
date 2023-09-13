import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shopping/data/model/model_main_1_page/model_banners.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetMainNewCollectionsBody {

  Future<ModelBanners> getMainNewCollections() async {
    var dio = Dio();
    Response response;
    log("${BaseClass.url}/api/v1/web/banners/");
    response = await dio.get("${BaseClass.url}/api/v1/web/banners/");
    log(jsonEncode(response.data).toString());
    return ModelBanners.fromJson(response.data);
  }
}
