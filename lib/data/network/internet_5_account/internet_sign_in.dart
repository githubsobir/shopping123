import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetClientSignIn {
  var box = Hive.box("online");

  Future<String> getISignUp({
    required userName,
    required password,
  }) async {
    var dio = Dio();
    Response response;
    try {
      response = await dio.post(
        "${BaseClass.url}api/v1/auth/",
        data: {
          "username": userName,
          "password": password,
        },
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

  Future<String> getProfile() async {
    try {
      var dio = Dio();
      Response response = await dio.get("${BaseClass.url}api/v1/web/clients/profile/",
          options: Options(
              headers: {"Authorization": "Bearer ${box.get("token")}"}));

      return jsonEncode(response.data).toString();
    } catch (e) {
      log(e.toString());
      return "1234";

    }
  }
}
