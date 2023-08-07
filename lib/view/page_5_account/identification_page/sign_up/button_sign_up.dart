import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
import 'package:shopping/widgets/colors/app_colors.dart';

Widget buttonSignUp(
    {required BuildContext context}) {
  return Column(
     mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
    MaterialButton(
    height: 50,
    minWidth: double.infinity,
    color:  MyColors.appColorGrey400(),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: MyWidgets.robotoFontText(
        text: "registration".tr(), textColor: MyColors.appColorWhite()),
    onPressed: () {
      // if(providerSignUp.formKey.currentState!.validate()){}
      // if( providerSignUp.boolButtonColor1 &&
      //     providerSignUp.boolButtonColor2 &&
      //     providerSignUp.textCaptchaSignUpController.text.isNotEmpty){
      // providerSignUp.getRegistration(context: context);
      // }else{
      //   MyWidgets.scaffoldMessengerBottom(context: context, valueText: "checkField".tr());
      // }

    },
  ),
    const SizedBox(height: 30),
    ],
  );
}
