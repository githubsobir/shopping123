import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shopping/data/model/model_details/model_details.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetDetailsInformation {

  Future<ModelDetails> getDetailsInformation({required String id}) async {
    var dio = Dio();
    Response response;
    log(id.toString());
    response = await dio.get("${BaseUrl.url}/api/v1/web/products/$id");
    log(jsonEncode(response.data).toString());
    return ModelDetails.fromJson(response.data);
  }
}
