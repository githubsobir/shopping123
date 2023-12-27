import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:shopping/data/model/model_3_basket/model_basket_get_all.dart';
import 'package:shopping/data/network/base_url.dart';

class InternetGetBasketList {
  var dio = Dio();
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

  Future<ModelBasketList> getDataBasketList() async {
    ModelBasketList modelBasketList;
    Response response = await dio.get(
        "${BaseClass.url}api/v1/web/carts/?session_id=${getIpOrTokenWithOutBearer()}");
    log(jsonEncode(response.data).toString());
    try{
       modelBasketList = ModelBasketList.fromJson(response.data);
    }catch(e){
       modelBasketList = ModelBasketList(results: [], errorText: "Ma'lumot olishda xatolik", internetStatePosition: "2");
    }
    return modelBasketList;
  }
}
