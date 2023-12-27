import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/view/page_5_account/identification_page/enter_first/controller_login.dart';
import 'package:shopping/view/page_5_account/identification_page/sign_up/sign_up.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
import 'package:shopping/widgets/colors/app_colors.dart';

Widget enterFirstBodyInput({
  required BuildContext context,
}) {
  TextEditingController textAuthLogin =
      TextEditingController();
  TextEditingController textAuthPassword =
      TextEditingController();
  bool myBoolWidget = false;
  bool boolButtonColor1 = false;
  boolButtonCol1({required bool boolValue}) {
    boolButtonColor1 = boolValue;
  }


  return Column(
    // mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      MyWidgets.robotoFontText(text: "telephoneUser".tr()),
      TextFormField(
          controller: textAuthLogin,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          maxLength: 9,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          decoration: InputDecoration(
            prefixText: "+998 ",
            suffixIcon: GestureDetector(
              child: const Icon(Icons.clear, size: 12),
              onTap: () {
                textAuthLogin.clear();
              },
            ),
            contentPadding: const EdgeInsets.all(8),
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: MyColors.appColorBlue1(),
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
            errorMaxLines: 2,
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
          ),
          validator: (value) {
            if (value == null || value.toString().trim().length < 9) {
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
                return "kodEmpty".tr();
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
      const SizedBox(height: 10),
      MyWidgets.robotoFontText(text: "password".tr()),
      Consumer(
        builder: (context, ref, child) => TextFormField(
              controller: textAuthPassword,
              textAlignVertical: TextAlignVertical.center,
              maxLines: 1,
              maxLength: 20,
              autofocus: ref.watch(visiblePassword),
              obscureText:  ref.watch(visiblePassword),
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8),
                suffixIcon: GestureDetector(
                  onTap: () {
                    ref.read(visiblePassword.notifier).state = !ref.watch(visiblePassword);
                  },
                  child: ref.watch(visiblePassword)
                      ? Icon(
                          CupertinoIcons.eye_slash,
                          color: MyColors.appColorGrey600(),
                          size: 18,
                        )
                      : Icon(
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
                if (value!.isEmpty || value.toString().trim().length < 8) {
                  return "passwordLength".tr();
                }
                return null;
              })
      ),
      const SizedBox(height: 20,),
      Consumer(
        builder: (context2, ref, child) => MaterialButton(
            height: 50,
            minWidth: double.infinity,
            color: MyColors.appColorUzBazar(),
            textColor: MyColors.appColorWhite(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              ref.read(checkSignIn.notifier).getDataSignIn(
                  userName: textAuthLogin.text.trim(),
                  password: textAuthPassword.text.trim(),
                  context: context);
            },
            child: MyWidgets.robotoFontText(
                text: "enterSystem".tr(), textColor: MyColors.appColorWhite())),
      ),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: [
            const Divider(),
            Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  color: MyColors.appColorWhite(),
                  // margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "or".tr(),
                    style: TextStyle(
                        backgroundColor: MyColors.appColorWhite(),
                        fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      ),

      GestureDetector(
        onTap: () {
          // textCaptchaEditingController.clear();
          //  enterSignUp(context: context);
          pushNewScreen(context, screen: SignUp());
        },
        child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: MyColors.appColorBlack())),
            child: Center(
                child: MyWidgets.robotoFontText(text: "registration".tr()))),
      ),
    ],
  );
}
