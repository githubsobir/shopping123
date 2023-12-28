import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shopping/data/model/model_3_basket/model_basket_get_all.dart';
import 'package:shopping/data/network/internet_3_basket/get_basket_list.dart';

final getOrder =
    StateNotifierProvider<BasketNotifierState, ModelBasketList>((ref) {
  return BasketNotifierState();
});

class BasketNotifierState extends StateNotifier<ModelBasketList> {
  BasketNotifierState() : super(ModelBasketList(results: [])) {
    getBasketList();
  }

  var box = Hive.box("online");
  var dio = Dio();

  InternetGetBasketList internetGetBasketList = InternetGetBasketList();

  Future getBasketList() async {
    try {
      state = state.copyWith("0", "0", "0", "0", "0", []);

      var modelBasketList = await internetGetBasketList.getDataBasketList();
      modelBasketList.internetStatePosition != "2"
          ? state = state.copyWith(modelBasketList.count, modelBasketList.next,
              modelBasketList.previous, "", "1", modelBasketList.results)
          : state = state.copyWith(
              modelBasketList.count,
              modelBasketList.next,
              modelBasketList.previous,
              modelBasketList.errorText,
              "2",
              modelBasketList.results);
    } on DioException catch (e) {
      try {
        state = state.copyWith(
            "0", "0", "0", e.error.toString(), "2", []);
      } catch (e) {
        state = state.copyWith("0", "0", "0", "error", "2", []);
      }
      log(e.toString());
    }
  }

  deleteInBasketList({required String id}) async {
    try {
      List<ResultBasketList> results = [...state.results];
      results.removeWhere((element) => element.product.id.toString() == id);
      state = state.copyWith(
          state.count, state.next, state.previous, "", "1", results);
    } catch (e) {
      // state =
      //     state.copyWith(state.count, state.next, state.previous, "","3", results);
    }
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
