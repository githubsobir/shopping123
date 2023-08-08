import 'package:dio/dio.dart';
import 'package:shopping/data/model/model_main_1_page/new_collection/new_collection_model.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetMainNewCollectionsBody {

  Future<ModelMainNewCollections> getMainNewCollections() async {
    var dio = Dio();
    Response response;
    response = await dio.get("${BaseUrl.url}/api/v1/web/banners/");
    // log(jsonEncode(response.data).toString());
    return ModelMainNewCollections.fromJson(response.data);
  }
}
