import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/model_main_search.dart';
import 'package:shopping/data/network/internet_main_1_page/internet_search.dart';


final apiMainSearchBrands =
Provider<InternetMainSearch>((ref) => InternetMainSearch());

final getMainSearchBrandData = FutureProvider<ModelMainSearchBrend>((ref) {
  // log(ref.read(apiMainSearchBrands).getMainSearchBrand().toString());
  return ref.read(apiMainSearchBrands).getMainSearchBrand();
});