import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/data/network/internet_main_1_page/internet_body.dart';



final apiProviderBestSeller = Provider<InternetMainBody>(
        (ref) => InternetMainBody());

final getDataBestSeller =
    FutureProvider.family<List<ResultProductList>, ModelSearch>(
        (ref, modelSearch)  {
          return ref.read(apiProviderBestSeller).getInfiniteList(modelSearch: modelSearch);
  // var dio = Dio();
  // ModelProductList modelProductList = ModelProductList(
  //     count: "", next: "", previous: "", results: []);
  //
  // Response response = await dio.get(
  //     "${BaseClass.url}/api/v1/web/products/?${BaseClass.getLinkSearch(m: modelSearch)}",
  //     options: Options(
  //         headers: {"X-Access-Token": "82f8ad497b5b70cfed09a68e522a3e94"}));
  //
  // try {
  //   log(jsonEncode(response.data).toString());
  //   modelProductList = ModelProductList.fromJson(response.data);
  // } catch (e) {
  //   log(e.toString());
  // }
  //
  // return modelProductList.results;
  // // return
});
