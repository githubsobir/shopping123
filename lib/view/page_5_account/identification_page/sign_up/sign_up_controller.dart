import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/network/internet_5_account/internet_cleant_sign_up.dart';

class ControllerSignUp {}

class ModelSignUp extends StateNotifier<ClientSignUp> {
  ModelSignUp()
      : super(ClientSignUp(
    fullName: "",
    phoneNumber: "",
    password: "",
    isActive: "",
    fileImage: "",
  ));

  InternetClientSignUp internetClientSignUp = InternetClientSignUp();
  bool boolGetData = false;

  Future getData({
    required ClientSignUp clientSignUp
    // required String fullName123,
    // required String phoneNumber123,
    // required String password123,
    // required String isActive123,
    // required String fileImage123,
  }) async {
    boolGetData = false;
    String data = await internetClientSignUp.getISignUp(
        fullName: clientSignUp.fullName,
        phoneNumber: clientSignUp.phoneNumber,
        password: clientSignUp.password,
        isActive: clientSignUp.isActive,
        fileImage: clientSignUp.fileImage);
    boolGetData = true;
    log(data.toString());
  }
}

class ClientSignUp {
  String fullName;
  String phoneNumber;
  String password;
  String isActive;
  dynamic fileImage;

  ClientSignUp({required this.fullName,
    required this.phoneNumber,
    required this.password,
    required this.isActive,
    required this.fileImage});
}

