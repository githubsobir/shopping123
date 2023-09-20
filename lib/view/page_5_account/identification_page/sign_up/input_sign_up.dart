import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/view/page_5_account/identification_page/sign_up/sign_up_controller.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
import 'package:shopping/widgets/colors/app_colors.dart';

Widget inputsSignUp({required BuildContext context, required WidgetRef ref}) {
  bool boolPasswordVisible = true;
  TextEditingController textSingUpName = TextEditingController();
  TextEditingController textSingUpLogin = TextEditingController();
  TextEditingController textSingUpPassword = TextEditingController();
  TextEditingController textSingUpPassword2 = TextEditingController();
  bool boolCheckName = false;
  bool boolCheckPhone = false;
  bool boolCheckPass1 = false;
  bool boolCheckPass2 = false;
  bool boolButtonColor1 = false;
  bool myBoolWidget = false;
//
  boolButtonCol1({required bool boolValue}) async {
    boolButtonColor1 = boolValue;
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      MyWidgets.robotoFontText(text: "name".tr()),
      TextFormField(
          controller: textSingUpName,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          maxLength: 30,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixText: "",
            contentPadding: const EdgeInsets.all(8),
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: MyColors.appColorBlue2(),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: MyColors.appColorGrey100(),
                width: 2.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: MyColors.appColorGrey100(),
                width: 2.0,
              ),
            ),
            errorStyle: TextStyle(
              color: MyColors.appColorRed(),
              fontWeight: FontWeight.w500,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: MyColors.appColorGrey100(),
                width: 2.0,
              ),
            ),
            // focusedBorder: UnderlineInputBorder(
            //   borderSide: BorderSide(color: MyColors.appColorBackC4()),
            // ),
            errorMaxLines: 2,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "errorName".tr();
            }
            return null;
          }),
      const SizedBox(height: 5),
      MyWidgets.robotoFontText(text: "phoneNumber".tr()),
      const SizedBox(height: 5),
      TextFormField(
          controller: textSingUpLogin,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          maxLength: 9,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          decoration: InputDecoration(
            prefixText: "+998 ",
            contentPadding: const EdgeInsets.all(8),
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: MyColors.appColorBlue2(),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: MyColors.appColorGrey100(),
                width: 2.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: MyColors.appColorGrey100(),
                width: 2.0,
              ),
            ),
            errorStyle: TextStyle(
              color: MyColors.appColorRed(),
              fontWeight: FontWeight.w500,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: MyColors.appColorGrey100(),
                width: 2.0,
              ),
            ),
            // focusedBorder: UnderlineInputBorder(
            //   borderSide: BorderSide(color: MyColors.appColorBackC4()),
            // ),
            errorMaxLines: 2,
          ),
          validator: (value) {
            if (value == null || value.length < 9) {
              boolButtonCol1(boolValue: false);
              if (value!.length > 1) {
                String kod = value.substring(0, 2);
                for (var element in MyWidgets.checkTelephoneCompanyCode) {
                  if (element.contains(kod)) {
                    myBoolWidget = true;
                    break;
                  } else {
                    myBoolWidget = false;
                  }
                }
                if (!myBoolWidget && value.length < 3) {
                  return "kodError".tr();
                } else {
                  return "kodLength".tr();
                }
              } else {
                return "phoneNumber".tr();
              }
            } else {
              String kod = value.substring(0, 2);
              for (var element in MyWidgets.checkTelephoneCompanyCode) {
                if (element.contains(kod)) {
                  myBoolWidget = true;
                  boolButtonCol1(boolValue: true);
                  break;
                } else {
                  boolButtonCol1(boolValue: false);
                  myBoolWidget = false;
                }
              }
              if (!myBoolWidget) {
                boolButtonCol1(boolValue: false);
                return "kodError".tr();
              } else {
                boolButtonCol1(boolValue: true);
              }
            }
            return null;
          }),
      const SizedBox(height: 5),
      MyWidgets.robotoFontText(text: "password".tr()),
      TextFormField(
        controller: textSingUpPassword,
        textAlignVertical: TextAlignVertical.center,
        maxLines: 1,
        maxLength: 20,
        obscureText: boolPasswordVisible,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          suffixIcon: GestureDetector(
            onTap: () {
              // providerSignUp.boolPasswordVisibleMethod();
            },
            child: Icon(
              CupertinoIcons.eye,
              color: MyColors.appColorBlue2(),
              size: 18,
            ),
          ),
          fillColor: Colors.white,
          errorMaxLines: 2,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: MyColors.appColorBlue2(),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: MyColors.appColorGrey100(),
              width: 2.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: MyColors.appColorGrey100(),
              width: 2.0,
            ),
          ),
          errorStyle: TextStyle(
            color: MyColors.appColorRed(),
            fontWeight: FontWeight.w500,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: MyColors.appColorGrey100(),
              width: 2.0,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.length < 8) {
            return "passwordLength".tr();
          }
          return "";
        },
      ),
      const SizedBox(height: 5),
      MyWidgets.robotoFontText(text: "passwordAgain".tr()),
      TextFormField(
        controller: textSingUpPassword2,
        textAlignVertical: TextAlignVertical.center,
        maxLines: 1,
        maxLength: 20,
        obscureText: boolPasswordVisible,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          suffixIcon: GestureDetector(
            onTap: () {
              // providerSignUp.boolPasswordVisibleMethod();
            },
            child: Icon(
              CupertinoIcons.eye,
              color: MyColors.appColorBlue2(),
              size: 18,
            ),
          ),
          fillColor: Colors.white,
          errorMaxLines: 2,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: MyColors.appColorBlue2(),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: MyColors.appColorGrey100(),
              width: 2.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: MyColors.appColorGrey100(),
              width: 2.0,
            ),
          ),
          errorStyle: TextStyle(
            color: MyColors.appColorRed(),
            fontWeight: FontWeight.w500,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: MyColors.appColorGrey100(),
              width: 2.0,
            ),
          ),
        ),
        validator: (value) {
          if (value.toString() != textSingUpPassword.text.toString()) {
            return "passwordNotEqu".tr();
          }
          return "";
        },
      ),
      const SizedBox(height: 20),
      MaterialButton(
        height: 50,
        minWidth: double.infinity,
        color: MyColors.appColorGrey400(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: MyWidgets.robotoFontText(
            text: "registration".tr(), textColor: MyColors.appColorWhite()),
        onPressed: () {
          log("123");
          try {
            log("log - 0");

            ref.read(getDataSignUp.notifier).getSignUp(modelForSignUp: ModelForSignUp(
                fullName: "Sobir",
                phone: "998489900",
                password: "Parol2345678",
                isActive: "1",
                fileImage: "fileImage"));
            log("log - 1");
            // if (textSingUpName.text.length > 1 &&
            //     textSingUpLogin.text.length == 9 &&
            //     textSingUpPassword.text.length >= 8 &&
            //     textSingUpPassword2.text.length >= 8) {
            //   ref.read(getDataSignUp(ModelForSignUp(
            //       fullName: "Sobir",
            //       phone: "998489900",
            //       password: "Parol2345678",
            //       isActive: "1",
            //       fileImage: "fileImage")));
            //   log("log - 2");
            //
            //   log("log - 3");
            // } else {
            //   print("error showSnackBar");
            // }
          } catch (e) {
            log(e.toString());
          }
        },
      ),
      const SizedBox(height: 10),
    ],
  );
}
