import 'package:dio/dio.dart';
import 'package:shopping/data/network/base_url.dart';

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

    return (response.data).toString();
  }
}
