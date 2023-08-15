import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shopping/data/network/base_url.dart';
import 'package:shopping/view/page_5_account/identification_page/sign_up/sign_up_controller.dart';

class InternetClientSignUp {
  Future<String> getISignUp({
    required fullName,
    required phoneNumber,
    required password,
    required isActive,
    required fileImage,


}) async {
    var dio = Dio();
    Response response;
    FormData formData = FormData.fromMap({
      "full_name": fullName,
      "phone": phoneNumber,
      "password": password,
      "is_active": isActive,
    });
    response =
        await dio.post("${BaseUrl.url}/api/v1/web/clients/", data: {
          "full_name": fullName,
          "phone": phoneNumber,
          "password": password,
          "is_active": isActive,
        });
    log("jsonEncode(response.data).toString()");
    log(jsonEncode(response.data).toString());
    return (response.data).toString();
  }
}
