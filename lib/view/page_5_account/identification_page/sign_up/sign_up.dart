import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_5_account/model_sign_up.dart';
import 'package:shopping/view/page_5_account/identification_page/sign_up/app_bar_sign_up.dart';
import 'package:shopping/view/page_5_account/identification_page/sign_up/sign_up_controller.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
import 'package:shopping/widgets/colors/app_colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  bool myBoolWidget = false;
  bool boolButtonColor1 = false;
  TextEditingController textSingUpName = TextEditingController();
  TextEditingController textSingUpPhone = TextEditingController();
  TextEditingController textSingUpPassword = TextEditingController();
  TextEditingController textSingUpPassword2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarSignUp(context: context),
        body: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(20.0),
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWords(context: context),
                    Column(
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
                            controller: textSingUpPhone,
                            maxLines: 1,
                            textAlignVertical: TextAlignVertical.center,
                            maxLength: 9,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
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
                                // ref.read(boolViewPassword.notifier).state = false;
                                if (value!.length > 1) {
                                  String kod = value.substring(0, 2);
                                  for (var element
                                      in MyWidgets.checkTelephoneCompanyCode) {
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
                                for (var element
                                    in MyWidgets.checkTelephoneCompanyCode) {
                                  if (element.contains(kod)) {
                                    myBoolWidget = true;
                                    // ref.read(boolViewPassword.notifier).state = true;

                                    break;
                                  } else {
                                    // ref.read(boolViewPassword.notifier).state = false;
                                    myBoolWidget = false;
                                  }
                                }
                                if (!myBoolWidget) {
                                  // ref.read(boolViewPassword.notifier).state = false;
                                  return "kodError".tr();
                                } else {
                                  // ref.read(boolViewPassword.notifier).state = true;
                                }
                              }
                              return null;
                            }),
                        const SizedBox(height: 5),
                        MyWidgets.robotoFontText(text: "password".tr()),
                        Consumer(
                          builder: (context, ref, child) => TextFormField(
                            controller: textSingUpPassword,
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 1,
                            maxLength: 20,
                            obscureText: ref.watch(boolViewPassword),
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  ref.read(boolViewPassword.notifier).state =
                                      !ref.watch(boolViewPassword);
                                },
                                child: Icon(
                                  ref.watch(boolViewPassword)
                                      ? CupertinoIcons.eye_slash_fill
                                      : CupertinoIcons.eye,
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
                        ),
                        const SizedBox(height: 5),
                        MyWidgets.robotoFontText(text: "passwordAgain".tr()),
                        Consumer(
                          builder: (context, ref, child) => TextFormField(
                            controller: textSingUpPassword2,
                            textAlignVertical: TextAlignVertical.center,
                            maxLines: 1,
                            maxLength: 20,
                            obscureText: ref.watch(boolViewPassword),
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  ref.read(boolViewPassword.notifier).state =
                                      !ref.watch(boolViewPassword);
                                },
                                child: Icon(
                                  ref.watch(boolViewPassword)
                                      ? CupertinoIcons.eye_slash_fill
                                      : CupertinoIcons.eye,
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
                              if (value.toString() !=
                                  textSingUpPassword.text.toString()) {
                                return "passwordNotEqu".tr();
                              }
                              return "";
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Consumer(
                          builder: (context, ref, child) => GestureDetector(
                            onTap: () {
                              if (textSingUpName.text.isNotEmpty &&
                                  textSingUpPhone.text.length == 9 &&
                                  textSingUpPassword.text.trim().length > 7 &&
                                  textSingUpPassword.text.trim() ==
                                      textSingUpPassword2.text.trim()) {
                                ref.read(getDataSignUp.notifier).getSignUp(
                                    context: context,
                                    modelSignUpServer: ModelSignUpServer(
                                        fullName: textSingUpName.text.trim(),
                                        phone: textSingUpPhone.text.trim(),
                                        password: textSingUpPassword.text.trim(),
                                        isActive: "1",
                                        fileImage: "1"));
                              }else{
                                MyWidgets.bottomSheetUniversal(text: "Ma'lumot kiritishda xatolik qayta uruning.",context: context,);
                              }


                            },
                            child: Container(
                                width: double.infinity,
                                height: 55,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("registration".tr(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            )));
  }

  Widget textWords({required BuildContext context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyWidgets.robotoFontText(
            text: "registration".tr(),
            textColor: MyColors.appColorBlack(),
            textFontWeight: FontWeight.bold,
            textSize: 22),
        const SizedBox(height: 10),
        FittedBox(
          child: MyWidgets.robotoFontText(
              text: "phoneNumberNewPassword".tr(),
              textColor: MyColors.appColorGrey600(),
              textSize: 13),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
