import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shopping/data/model/model_4_favourite/model_favourite.dart';
import 'package:shopping/data/network/base_url.dart';
import 'package:shopping/data/network/internet_4_favourite/internet_favourite_list.dart';

final getFavouriteList =
    StateNotifierProvider<FavoriteStateNotifier, ModelFavouriteStateNotifier>(
        (ref) => FavoriteStateNotifier());

final boolGetDataAction = StateProvider<bool>((ref) => false);

class FavoriteStateNotifier extends StateNotifier<ModelFavouriteStateNotifier> {
  FavoriteStateNotifier()
      : super(ModelFavouriteStateNotifier(
            next: "", previous: "", count: "", results: [])) {
    getFavouriteListFirst();
  }

  InternetGetFavouriteList getFavouriteList = InternetGetFavouriteList();

  Future getFavouriteListFirst() async {
    try {
      state = state.copyWith("", "", "", "0", "", []);
      String dataFavourite = await getFavouriteList.getDataFavouriteList();
      log("istaklar server murojaat");
      log(dataFavourite);
      ModelFavouriteStateNotifier modelFavouriteStateNotifier =
          ModelFavouriteStateNotifier.fromJson(jsonDecode(dataFavourite));
      state = state.copyWith(
          modelFavouriteStateNotifier.count.toString(),
          modelFavouriteStateNotifier.next.toString(),
          modelFavouriteStateNotifier.previous.toString(),
          "1",
          "",
          modelFavouriteStateNotifier.results);
    } on DioException catch (e) {
     try {
        state = state
            .copyWith("", "", "", "3", e.response!.statusCode.toString(), []);
      }catch(e){
       state = state
           .copyWith("", "", "", "3", e.toString(), []);
     }
      log(e.response!.statusCode.toString());
    }
  }

  setFavouriteList({required ResultModelNotifier resultModelNotifier}) {
    List<ResultModelNotifier> listResult = [];
    listResult = state.results;

    if (!resultModelNotifier.isActive) {
      listResult.removeWhere((element) => element.id == resultModelNotifier.id);
    } else {

      listResult.add(resultModelNotifier);
    }
    state = state.copyWith(
        state.count, state.next, state.previous, true, "",listResult);
  }

  /// layklarni serverga yuborish qo'shish

  var dio = Dio();
  Future setFavoritesServer({required String idProduct}) async {
    try {
      log("setFavoritesServer");
      Response response = await dio.post(
          "${BaseClass.url}api/v1/web/favorites/",
          options: Options(headers: {"Authorization": getIpOrToken()}),
          data: {
            "session_id": getIpOrTokenWithOutBearer(),
            "product": idProduct,
          });

      log(response.data.toString());
    } catch (e) {
      log(e.toString());
      return "";
    }
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
}