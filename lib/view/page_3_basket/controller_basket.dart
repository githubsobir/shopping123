import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shopping/data/model/model_3_basket/model_basket_get_all.dart';
import 'package:shopping/data/network/base_url.dart';

final getOrder =
    StateNotifierProvider<BasketNotifierState, ModelBasketList>((ref) {
  return BasketNotifierState();
});

class BasketNotifierState extends StateNotifier<ModelBasketList> {
  BasketNotifierState() : super(ModelBasketList(results: [])) {
    getBasketList();
  }

  var box = Hive.box("online");

  String getIpOrToken() {
    if (box.get("token").toString().length > 20) {
      return "Bearer ${box.get("token")}";
    } else {
      return box.get("ipAddressPhone").toString();
    }
  }

  String getIpOrTokenWithOutBearer() {
    if (box.get("token").toString().length > 20) {
      return box.get("token");
    } else {
      return box.get("ipAddressPhone").toString();
    }
  }

  var dio = Dio();

  Future getBasketList() async {
    try {
      log("https://uzbazar.husanibragimov.uz/api/v1/web/carts/?session_id=${getIpOrTokenWithOutBearer()}");
      Response response = await dio.get(
          "${BaseClass.url}api/v1/web/carts/?session_id=${getIpOrTokenWithOutBearer()}");
      ModelBasketList modelBasketList = ModelBasketList.fromJson(response.data);
      state = state.copyWith(modelBasketList.count, modelBasketList.next,
          modelBasketList.previous, modelBasketList.results);
    } catch (e) {
      log(e.toString());
    }
  }

  deleteInBasketList({required String id}) async {
    try {
      List<ResultBasketList> results = [...state.results];
      results.removeWhere((element) => element.product.id.toString() == id);
      state = state.copyWith(state.count, state.next, state.previous, results);
    } catch (e) {}
  }

  orderRequest() async {
    try {
      Response response = await dio.post(
          "https://uzbazar.husanibragimov.uz/api/v1/web/orders/?session_id=${box.get("ipAddressPhone").toString()}",
          options: Options(
              headers: {"Authorization": "Bearer ${box.get("token")}"}));

      log(jsonEncode(response.data).toString());
      log("orderRequest");
    } catch (e) {
      log(e.toString());
    }
  }

  getOrderList() async {
    try {} catch (e) {
      log("getOrderList");
      log(e.toString());
    }
  }
}
