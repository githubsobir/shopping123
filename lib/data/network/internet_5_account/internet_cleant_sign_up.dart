import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetClientSignUp {
  // dynamic fullName;
  // dynamic phoneNumber;
  // dynamic password;
  // dynamic isActive;
  // dynamic fileImage;
  //
  // InternetClientSignUp({
  //   required this.fullName,
  //   required this.phoneNumber,
  //   required this.password,
  //   required this.isActive,
  //   required this.fileImage,
  // });

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

    return jsonEncode(response.data).toString();
  }
}
