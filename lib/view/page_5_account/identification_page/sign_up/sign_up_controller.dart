import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shopping/data/model/model_5_account/model_sign_up.dart';
import 'package:shopping/data/model/model_5_account/model_sing_in.dart';
import 'package:shopping/data/model/model_5_account/model_user_profile.dart';
import 'package:shopping/data/network/internet_5_account/internet_cleant_sign_up.dart';
import 'package:shopping/data/network/internet_5_account/internet_sign_in.dart';
import 'package:shopping/view/page_0_root/root_page.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';

final boolViewPassword = StateProvider<bool>((ref) => false);

final getDataSignUp = StateNotifierProvider<SignUpNotifier, ModelForSignUp>((
  ref,
) =>
    SignUpNotifier());

class SignUpNotifier extends StateNotifier<ModelForSignUp> {
  SignUpNotifier()
      : super(ModelForSignUp(
            boolLoading: false, boolError: false, boolSuccess: false));
  InternetClientSignUp internetClientSignUp = InternetClientSignUp();

  /// registratsiya qilish uchun metod
  late ModelResponseSignUp modelResponseSignUp;
  late String userName, password;

  Future getSignUp(
      {required ModelSignUpServer modelSignUpServer,
      required BuildContext context}) async {
    try {
      state = state.copyWith(true, false, false);
      String data = await internetClientSignUp.getISignUp(
          fullName: modelSignUpServer.fullName,
          phoneNumber: modelSignUpServer.phone,
          password: modelSignUpServer.password,
          isActive: modelSignUpServer.isActive,
          fileImage: modelSignUpServer.fileImage);
      try {
        modelResponseSignUp = ModelResponseSignUp.fromJson(jsonDecode(data));
        userName = modelSignUpServer.phone;
        password = modelSignUpServer.password;
        if (!context.mounted) return;
        // Navigator.of(context).pop();
        getLogIn(context: context);
        log(data.toString());
      } catch (w) {
        if (data.contains("400")) {
          if (!context.mounted) return;
          MyWidgets.bottomSheetUniversal(
              text:
                  "Telefon raqamdan oldin ro'yxatdan o'tgan boshqa telefon raqam kiriting ",
              context: context);
        } else if (data.contains("404")) {
          if (!context.mounted) return;
          MyWidgets.bottomSheetUniversal(
              text: "404 Serverda xatolik keyinroq qayta urinib ko'ring",
              context: context);
        }
      }
    } catch (e) {
      state = state.copyWith(false, false, true);
      log(e.toString());
    }
  }

  /// registratsiya bo'lgan userga token olish
  InternetClientSignIn internetClientSignIn = InternetClientSignIn();
  ModelForSignInParse modelForSignInParse =
      ModelForSignInParse(pk: "", token: "");
  var box = Hive.box("online");
  late ModelUserProfile modelUserProfile;

  Future getLogIn({required BuildContext context}) async {
    try {
      String data = await internetClientSignIn.getISignUp(
          userName: userName, password: password);
      try {
        modelForSignInParse = ModelForSignInParse.fromJson(jsonDecode(data));
        box.put("token", modelForSignInParse.token.toString());
        String dataProfile = await internetClientSignIn.getProfile();
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
        state = state.copyWith(false, true, false);
        if (!context.mounted) return;
        getMainPage(context: context);
      } catch (w) {
        if (data.contains("400")) {
          if (!context.mounted) return;
          MyWidgets.bottomSheetUniversal(
              text:
                  "400  Serverda xatolik keyinroq qayta urinib ko'ring",
              context: context);
        } else if (data.contains("404")) {
          if (!context.mounted) return;
          MyWidgets.bottomSheetUniversal(
              text: "404 Serverda xatolik keyinroq qayta urinib ko'ring",
              context: context);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  getMainPage({required BuildContext context}) async {
    AwesomeDialog(
        context: context,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
        dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        dialogType: DialogType.noHeader,
        body: SizedBox(
          height: 180,
          child: Column(
            children: [
              const Text(
                "UZBEK BAZAR",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              const SizedBox(height: 20),
              Center(
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.red,
                  size: 60,
                )
                    .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true))
                    .scaleXY(
                        end: 2.2,
                        delay: const Duration(milliseconds: 600),
                        curve: Curves.easeInOutCirc)
                    .shimmer(
                        color: Colors.red,
                        delay: const Duration(milliseconds: 600))
                    .elevation(end: 0),
              ),
            ],
          ),
        )).show().then(
      (value) {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(
              builder: (context) => RootPage(homeIdMainpage: 0),
            ),
            (route) => false);
      },
    );
    await Future.delayed(const Duration(milliseconds: 900)).then((value) {
      Navigator.of(context).pop();
    });
  }
}
