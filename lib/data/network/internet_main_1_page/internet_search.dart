import 'package:dio/dio.dart';
import 'package:shopping/data/model/model_main_1_page/model_main_search.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetMainSearch {

  Future<ModelMainSearchBrend> getMainSearchBrand() async {
    var dio = Dio();
    Response response;
    response = await dio.get("${BaseUrl.url}/api/v1/web/brands/");
    // log(jsonEncode(response.data).toString());
    return ModelMainSearchBrend.fromJson(response.data);
  }
}
