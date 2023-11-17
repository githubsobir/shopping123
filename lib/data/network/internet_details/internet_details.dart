import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shopping/data/model/model_details/model_details.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetDetailsInformation {

  Future<ModelDetails> getDetailsInformation({required String id}) async {
    var dio = Dio();
    Response response;
    log("network");
    // response = await dio.get("${BaseClass.url}/api/v1/web/products/$id/");
    response = await dio.get("https://uzbazar.husanibragimov.uz/api/v1/web/products/$id/");
    log("network123");
    // log(jsonEncode(response.data).toString());
   try {
      log("network");

      return ModelDetails.fromJson(response.data);
    }catch(e){

     log(e.toString());
     return ModelDetails.fromJson(response.data);
   }
  }
}
