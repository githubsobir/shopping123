import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping/data/model/model_5_account/model_sing_in.dart';
import 'package:shopping/data/network/internet_5_account/internet_sign_in.dart';

final checkSignIn = StateNotifierProvider<SignInNotifier, ModelForSignIn>(
    (ref) => SignInNotifier());



class SignInNotifier extends StateNotifier<ModelForSignIn> {
  SignInNotifier()
      : super(ModelForSignIn(boolGetData: true, boolErrorData: false, errorDataText: "" )){
    ModelForSignIn(boolGetData: true, boolErrorData: false, errorDataText: "");
  }

  InternetClientSignIn internetClientSignIn = InternetClientSignIn();
  ModelForSignInParse modelForSignInParse = ModelForSignInParse(pk: "", token: "");


  var box = Hive.box("online");
  Future getDataSignIn({required String userName, required String password}) async {
    try {
      state = state.copyWith(false, false, "");

      String data = await internetClientSignIn.getISignUp(
          userName:userName , password: password);

      try{
        modelForSignInParse = ModelForSignInParse.fromJson(jsonDecode(data));

        box.put("token", modelForSignInParse.token.toString());
        state = state.copyWith(true, false, "");
      }catch(e){log(e.toString());}
      log(data);
      log(modelForSignInParse.pk.toString());
      log(modelForSignInParse.token);



    } catch (e) {
      log(e.toString());
    }
  }
}

class ModelForSignIn {
  bool boolGetData =  true;
  bool boolErrorData = false;
  String errorDataText = "";

  ModelForSignIn({
    required this.boolGetData,
    required this.boolErrorData,
    required this.errorDataText,
  });

  ModelForSignIn copyWith(
  bool boolGetData,
  bool boolErrorData,
  String errorDataText,
  ) {
    return ModelForSignIn(
         boolGetData: boolGetData,
        boolErrorData: boolErrorData,
         errorDataText: errorDataText);
  }

  factory ModelForSignIn.fromJson(Map<String, dynamic> json) => ModelForSignIn(
        boolGetData: json["boolGetData"],
    boolErrorData: json["errorData"],
        errorDataText: json["errorDataText"],
      );

  Map<String, dynamic> toJson() => {
        "boolGetData":boolGetData,
        "errorData":boolErrorData,
        "errorDataText":errorDataText,
      };
}
