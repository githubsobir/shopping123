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
    FormData formData = FormData.fromMap({
      "full_name": fullName,
      "phone": phoneNumber,
      "password": password,
      "is_active": "1",
    });
    response =
        await dio.post("${BaseClass.url}/api/v1/web/clients/", data: formData);
    log(jsonEncode(response.data).toString());
    return jsonEncode(response.data).toString();
  }
}
