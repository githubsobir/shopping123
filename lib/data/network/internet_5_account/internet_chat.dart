import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetChatGetList {
  Future<String> getChatList({
    required message,
    required id,
  }) async {
    var dio = Dio();
    Response response;
    final formData = FormData.fromMap({
      "message": message,
      "id": id,
    });

    try {
      response = await dio.post(
        "${BaseClass.url}message",
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
