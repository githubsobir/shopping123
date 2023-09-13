import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';

final getOrder =
    StateNotifierProvider<ModelProductListNotifier, ModelProductList>(
        (ref) {
  return ModelProductListNotifier();
});
