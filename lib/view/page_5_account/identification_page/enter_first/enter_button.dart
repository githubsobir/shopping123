import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/view/page_5_account/identification_page/sign_up/sign_up.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
import 'package:shopping/widgets/colors/app_colors.dart';
Widget enterButton(
    {required BuildContext context,}) {
  return Column(
    children: [
      MaterialButton(
          height: 50,
          minWidth: double.infinity,
          color: MyColors.appColorUzBazar(),
          textColor: MyColors.appColorWhite(),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            // providerEnterFirst.enterPersonPassport(context: context);

          },
          child: MyWidgets.robotoFontText(
              text: "enterSystem".tr(), textColor: MyColors.appColorWhite())),
      const SizedBox(height: 10),

      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: [
         const  Divider(),
            Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  color: MyColors.appColorWhite(),
                  // margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    "or".tr(),
                    style: TextStyle(backgroundColor: MyColors.appColorWhite(), fontWeight: FontWeight.bold),
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
