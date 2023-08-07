import 'package:dio/dio.dart';
import 'package:shopping/data/model/model_main_1_page/model_main_body.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetMainBody {

  Future<ModelMainBody> getCarouselData({required String data}) async {
    var dio = Dio();
    Response response;
    response = await dio.get("${BaseUrl.url}/api/v1/web/banners/");
    // log(jsonEncode(response.data).toString());
    return ModelMainBody.fromJson(response.data);
  }
}
