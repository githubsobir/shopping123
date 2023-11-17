import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shopping/data/model/model_main_1_page/model_main_carusel.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetMainCarousel {

  Future<ModelMainPageCarusel> getCarouselData() async {
    var dio = Dio();
    Response response;
    response = await dio.get("${BaseClass.url}api/v1/web/banners/");
    // log("web/banners");
    // log(jsonEncode(response.data).toString());
    return ModelMainPageCarusel.fromJson(response.data);
  }
}
