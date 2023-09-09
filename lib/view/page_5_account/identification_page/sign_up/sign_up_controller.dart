import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_5_account/model_sign_up.dart';
import 'package:shopping/data/network/internet_5_account/internet_cleant_sign_up.dart';

final apiProviderSignUp =
    Provider<InternetClientSignUp>((ref) => InternetClientSignUp());

final userSignUp =
    FutureProvider.family<String, ModelSignUp>((ref, data) async {
  String userStatus = "";
  String data1 = await ref.read(apiProviderSignUp).getISignUp(
      fullName: data.fullName,
      phoneNumber: data.phoneNumber,
      password: data.password,
      isActive: "1",
      fileImage: "fileImage");
  try {
    userStatus = ModelSignUpResponse.fromJson(jsonDecode(data1)).id.toString();
    log(userStatus);
  } catch (e) {
    userStatus = "0";
  }
  log(userStatus);

  return userStatus;
});

final userSignIn =
    FutureProvider.family<String, ModelSignUp>((ref, data2) async {
  return "";
});

// class ModelSignUp extends StateNotifier<ClientSignUp> {
//   ModelSignUp()
//       : super(ClientSignUp(
//           fullName: "",
//           phoneNumber: "",
//           password: "",
//           isActive: "",
//           fileImage: "",
//         ));
//
//   InternetClientSignUp internetClientSignUp = InternetClientSignUp();
//   bool boolGetData = false;
//
//   Future getData({required ClientSignUp clientSignUp}) async {
//     boolGetData = false;
//     String data = await internetClientSignUp.getISignUp(
//         fullName: clientSignUp.fullName,
//         phoneNumber: clientSignUp.phoneNumber,
//         password: clientSignUp.password,
//         isActive: clientSignUp.isActive,
//         fileImage: clientSignUp.fileImage);
//     boolGetData = true;
//     log(data.toString());
//   }
// }
