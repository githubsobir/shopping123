import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shopping/data/network/base_url.dart';

final ratingNotifier =
    StateNotifierProvider<RatingNotifier, ModelRatingNotifier>(
        (ref) => RatingNotifier());

class RatingNotifier extends StateNotifier<ModelRatingNotifier> {
  RatingNotifier() : super(ModelRatingNotifier(0, 0, ""));

  Future sendServerRating(
      {
      required String rating,
      required String comment,
      required String product,
      required String client}) async {
    try {
      log("ishladi 2");
      Map<String, dynamic> mapData = {
        "rating":rating, //
        "comment":comment, //*
        "product":product, //*
        // "client":client, //
      };
      log(jsonEncode(mapData));

      Response response = await Dio().post(
        "${BaseClass.url}api/v1/web/reviews/",
        data: mapData,
        options: Options(headers: {"Authorization": getIpOrToken()}),
      );
      log("ishladi");
      log(jsonEncode(response.data).toString());

    } catch (e) {
      log(e.toString());
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
}

class ModelRatingNotifier {
  dynamic loading;
  dynamic sending;
  dynamic errorText;

  ModelRatingNotifier(this.loading, this.sending, this.errorText);

  ModelRatingNotifier copyWith(
    dynamic loading1,
    dynamic sending1,
    dynamic errorText1,
  ) {
    return ModelRatingNotifier(
        loading1 ?? loading, sending1 ?? sending, errorText1 ?? errorText);
  }

  factory ModelRatingNotifier.fromJson(Map<String, dynamic> json) {
    return ModelRatingNotifier(
        json["loading"], json["sending"], json["errorText"]);
  }
}
