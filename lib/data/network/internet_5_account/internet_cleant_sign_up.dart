import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetClientSignUp {
  Future<String> getISignUp(
      {required fullName,
      required phoneNumber,
      required password,
      required isActive,
      required fileImage}) async {
    var dio = Dio();
    Response response;
    final formData = FormData.fromMap({
      "full_name": fullName,
      "phone": phoneNumber,
      "password": password,
      "is_active": isActive,
    });
    log("${BaseClass.url}api/v1/web/clients/");
    try {
      response = await dio.post(
        "${BaseClass.url}api/v1/web/clients/",
        data: formData,
      );
      return jsonEncode(response.data).toString();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return "404";
      } else if (e.response?.statusCode == 400) {
        return "400";
      } else {
        return "";
      }
    }
  }
}
