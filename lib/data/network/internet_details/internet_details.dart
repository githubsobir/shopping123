import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shopping/data/model/model_details/model_details.dart';

class InternetDetailsInformation {

  Future<ModelDetails> getDetailsInformation({required String id}) async {
    var dio = Dio();
    Response response;
    log("network 1");
    // response = await dio.get("${BaseClass.url}/api/v1/web/products/$id/");
        try{
      response = await dio
          .get("https://uzbazar.husanibragimov.uz/api/v1/web/products/$id/");
      log(jsonEncode(response.data).toString());
      log("network123");
      // log(jsonEncode(response.data).toString());
      try {
        log("network");

        return ModelDetails.fromJson(response.data);
      } catch (e) {
        log(e.toString());
        return ModelDetails.fromJson(response.data);
      }
    }catch(e){
          log(e.toString());
          return ModelDetails(variables: [], prices: [], size: []);
        }
  }
}
