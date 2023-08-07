import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shopping/data/model/model_5_account/model_account_info.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetAccountInformation {

  Future<ModelAccountInformation> getInformation() async {
    var dio = Dio();
    Response response;
    response = await dio.get("${BaseUrl.url}/api/v1/web/questions/");
    log(jsonEncode(response.data).toString());
    return ModelAccountInformation.fromJson(response.data);
  }
}
