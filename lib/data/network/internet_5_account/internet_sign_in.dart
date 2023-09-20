import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetClientSignIn {
  Future<String> getISignUp({
    required userName,
    required password,
  }) async {
    var dio = Dio();
    Response response;
    response = await dio.post("${BaseClass.url}/api/v1/auth/", data: {
      "username": userName,
      "password": password,
    });
    // log(jsonEncode(response.data).toString());
    return jsonEncode(response.data).toString();
  }
}
