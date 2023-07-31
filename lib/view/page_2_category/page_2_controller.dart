import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_2_category/model_category.dart';
import 'package:shopping/data/network/internet_2_category/internet_category.dart';



final apiCategory =
Provider<InternetMainCategory>((ref) => InternetMainCategory());

final getCategoryData = FutureProvider<ModelCategoryGet>((ref) {
  // log(ref.read(apiCategory).getCategory().toString());
  return ref.read(apiCategory).getCategory();
});
