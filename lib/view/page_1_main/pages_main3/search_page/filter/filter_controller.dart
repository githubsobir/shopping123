import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_1_main/model_color/model_brand.dart';
import 'package:shopping/data/model/model_1_main/model_color/model_color.dart';
import 'package:shopping/data/model/model_1_main/model_color/model_sizes.dart';
import 'package:shopping/data/network/base_url.dart';

final selectedBrandProvider = StateProvider<int>((ref) {
  return 0;
});
final selectedBrandIdProvider = StateProvider<String>((ref) {
  return "";
});
final selectRegionProvider = StateProvider<String>((ref) {
  return '';
});
final selectColorIndexProvider = StateProvider<int>((ref) {
  return 0;
});
final selectColorQueryProvider = StateProvider<String>((ref) {
  return "";
});

final selectSizeIndexProvider = StateProvider<int>((ref) {
  return 0;
});
final startValueProvider = StateProvider<double>((ref) {
  return 1;
});
final endValueProvider = StateProvider<double>((ref) {
  return 10000;
});

final getColor = FutureProvider<ModelGetColor>((ref) async {
  var dio = Dio();
  Response response = await dio.get("${BaseClass.url}api/v1/web/colors/");
  ModelGetColor modelGetColor = ModelGetColor.fromJson(response.data);
  return modelGetColor;
});

final getSize = FutureProvider<ModelGetSizes>((ref) async {
  var dio = Dio();
  Response response = await dio.get("${BaseClass.url}api/v1/web/sizes/");
  ModelGetSizes modelGetSize = ModelGetSizes.fromJson(response.data);
  return modelGetSize;
});

// api/v1/web/brands/


final getBrands = FutureProvider<ModelGetBrands>((ref) async {
  var dio = Dio();
  Response response = await dio.get("${BaseClass.url}api/v1/web/brands/");
  ModelGetBrands modelGetBrands = ModelGetBrands.fromJson(response.data);
  return modelGetBrands;
});