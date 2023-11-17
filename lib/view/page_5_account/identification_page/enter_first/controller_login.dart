// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/data/model/model_5_account/model_sing_in.dart';
import 'package:shopping/data/model/model_5_account/model_user_profile.dart';
import 'package:shopping/data/network/internet_5_account/internet_sign_in.dart';
import 'package:shopping/view/page_0_root/root_page.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';

final checkSignIn = StateNotifierProvider<SignInNotifier, ModelForSignIn>(
    (ref) => SignInNotifier());

final visiblePassword = StateProvider<bool>((ref) => false);

final getUserProfileInfoState = StateProvider<ModelUserProfile>(
    (ref) => ModelUserProfile(id: "", fullName: "", avatar: "", phone: ""));

class SignInNotifier extends StateNotifier<ModelForSignIn> {
  SignInNotifier()
      : super(ModelForSignIn(
            boolGetData: true, boolErrorData: false, errorDataText: "")) {
    ModelForSignIn(boolGetData: true, boolErrorData: false, errorDataText: "");
  }

  InternetClientSignIn internetClientSignIn = InternetClientSignIn();
  ModelForSignInParse modelForSignInParse =
      ModelForSignInParse(pk: "", token: "");

  var box = Hive.box("online");
  late ModelUserProfile modelUserProfile;

  Future getDataSignIn(
      {required String userName,
      required String password,
      required BuildContext context}) async {
    try {
      state = state.copyWith(false, false, "");

      String data = await internetClientSignIn.getISignUp(
          userName: userName, password: password);

      try {
        modelForSignInParse = ModelForSignInParse.fromJson(jsonDecode(data));

        box.put("token", modelForSignInParse.token.toString());

        String dataProfile = await internetClientSignIn.getProfile();
        // ref.read(getUserProfileInfoState.notifier).state = ModelUserProfile.fromJson(jsonDecode(dataProfile));
        modelUserProfile = ModelUserProfile.fromJson(jsonDecode(dataProfile));
        /// delete
        box.delete("userId");
        box.delete("userName");
        box.delete("userPhone");
        box.delete("userAvatar");
        /// save
        box.put("userId", modelUserProfile.id.toString());
        box.put("userName", modelUserProfile.fullName.toString());
        box.put("userPhone", modelUserProfile.phone.toString());
        box.put("userAvatar", modelUserProfile.avatar.toString());


        log(dataProfile);
        goBackAccountPage(context: context);
        state = state.copyWith(true, false, "");
      } catch (w) {
        if (data.contains("400")) {
          state = state.copyWith(true, false, "");
          if (!context.mounted) return;

          MyWidgets.bottomSheetUniversal(
              text:
              "Login yoki parolda xatolik qayta urining.",
              context: context);
        } else if (data.contains("404")) {
          state = state.copyWith(true, false, "");
          if (!context.mounted) return;
          MyWidgets.bottomSheetUniversal(
              text: "404 Serverda xatolik keyinroq qayta urinib ko'ring",
              context: context);
        }
      }
      log(data);
      log(modelForSignInParse.pk.toString());
      log(modelForSignInParse.token);
    } catch (e) {
      log(e.toString());
    }
  }

  goBackAccountPage({required BuildContext context}) {
    pushNewScreen(context,
        screen: RootPage(homeIdMainpage: 4), withNavBar: true);
    // Navigator.pushReplacement(
    //     context,
    //     CupertinoPageRoute(
    //       builder: (context) => AccountPage(),
    //     ));
  }
}

class ModelForSignIn {
  bool boolGetData = true;
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
        "boolGetData": boolGetData,
        "errorData": boolErrorData,
        "errorDataText": errorDataText,
      };
}
