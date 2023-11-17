import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/view/page_0_root/root_page.dart';
import 'package:shopping/view/page_5_account/identification_page/enter_first/enter_first.dart';
import 'package:shopping/view/page_5_account/service_account_page/service_account_page.dart';
import 'package:shopping/view/page_5_account/user_not_token/user_not_token.dart';
import 'package:shopping/view/page_5_account/user_with_token/user_with_token.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  var box = Hive.box("online");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "personalCabinet".tr(),
            style: const TextStyle(color: Colors.black),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                box.get("token").toString().length > 20
                    ? userWithTokenUI()
                    : userNotTokenUI(),

                /// list_tile lar
                serviceAccountPage(context: context),
                const SizedBox(height: 40),
                box.get("token").toString().length > 20
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: MaterialButton(
                            color: Colors.grey.shade50,
                            height: 50,
                            minWidth: double.infinity,
                            //MediaQuery.of(context).size.width * 0.5,
                            onPressed: () {
                              /// chiqish action
                              showModelDialog();
                            },
                            child: const Text("Chiqish")))
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: MaterialButton(
                            color: Colors.grey.shade50,
                            height: 50,
                            // minWidth: double.infinity,
                            //MediaQuery.of(context).size.width * 0.5,
                            onPressed: () {
                              pushNewScreen(context,
                                  screen: EnterFirst(windowIdEnterFirst: "0"),
                                  withNavBar: false);
                            },
                            child: Text("enter".tr()))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showModelDialog() {
    AwesomeDialog(
            context: context,
            title: "UZBAZARZ",
            desc: "logUot".tr(),
            dialogBackgroundColor: Colors.white,
            headerAnimationLoop: false,
            dialogType: DialogType.noHeader,
            btnCancelText: "yes".tr(),
            btnOkText: "no".tr(),
            barrierColor: Colors.black.withOpacity(0.5),
            buttonsTextStyle: const TextStyle(color: Colors.black),
            // btnCancelIcon: Icons.delete_forever_rounded,
            btnCancelColor: Colors.grey[400],
            btnOkColor: Colors.grey[100],
            buttonsBorderRadius: BorderRadius.circular(10),
            btnCancelOnPress: () {
              box.delete("userId");
              box.delete("userName");
              box.delete("userPhone");
              box.delete("userAvatar");
              box.delete("token");
              pushNewScreen(context,
                  screen: RootPage(homeIdMainpage: 0), withNavBar: false);
            },
            btnOkOnPress: () {})
        .show();
  }
}
