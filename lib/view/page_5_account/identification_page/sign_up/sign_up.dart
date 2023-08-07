import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shopping/view/page_5_account/identification_page/sign_up/app_bar_sign_up.dart';
import 'package:shopping/view/page_5_account/identification_page/sign_up/button_sign_up.dart';
import 'package:shopping/view/page_5_account/identification_page/sign_up/input_sign_up.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
import 'package:shopping/widgets/colors/app_colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  @override
  void initState() {
    super.initState();
  }
  final formKey = GlobalKey<FormState>();
  bool myBoolWidget = false;
  bool boolButtonColor1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.appColorWhite(),
        appBar:
        appBarSignUp( context: context),
        body: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        textWords(
                            context: context),
                        inputsSignUp(
                            context: context, ),
                        const SizedBox(height: 5),
                      ],),
                    Column(children: [

                      buttonSignUp(
                          context: context),
                    ],),


                  ],
                ),
              ),
            )));
  }

  Widget textWords(
      {required BuildContext context}) {
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
