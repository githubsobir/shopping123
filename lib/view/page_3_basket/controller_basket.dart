import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';

final getOrder =
    StateNotifierProvider<ModelProductListNotifier, List<ResultProductList>>(
        (ref) {
  return ModelProductListNotifier(ref.watch(getList));
});
