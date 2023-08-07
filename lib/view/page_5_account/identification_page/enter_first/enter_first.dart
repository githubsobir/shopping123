// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shopping/view/page_5_account/identification_page/enter_first/app_bar.dart';
import 'package:shopping/view/page_5_account/identification_page/enter_first/enter_button.dart';
import 'package:shopping/view/page_5_account/identification_page/enter_first/forgot_pasword.dart';
import 'package:shopping/view/page_5_account/identification_page/enter_first/inputs.dart';
import 'package:shopping/widgets/colors/app_colors.dart';

class EnterFirst extends StatefulWidget {
  String windowIdEnterFirst = "";
   EnterFirst({Key? key, required this.windowIdEnterFirst}) : super(key: key);

  @override
  State<EnterFirst> createState() => _EnterFirstState();
}

class _EnterFirstState extends State<EnterFirst> {
  var box = Hive.box("online");

  @override
  void initState() {
    log(box.get("clothe5Min").toString());
    log(box.get("errorTry").toString());

    super.initState();
  }
  bool boolPasswordVisible = true;
  final formKey = GlobalKey<FormState>();
  bool myBoolWidget = false;
  bool boolButtonColor1 = false;
  TextEditingController textAuthLogin = TextEditingController();
  TextEditingController textAuthPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          backgroundColor: MyColors.appColorWhite(),
          appBar: enterFirstAppBar(
              context: context),
          body: (box.get("clothe5Min") != "0" &&
              box.get("clothe5Min") != null)
              ? Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("userBlock5MIn".tr(), textAlign: TextAlign.center),
            ),
          )
              : Form(
              key: formKey,
              autovalidateMode:
              AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Image.asset("assets/images/shopping1.png",
                          height: 100),
                      const SizedBox(height: 10),
                      Text(
                        "UzBazar",
                        style: TextStyle(
                            color: MyColors.appColorUzBazar(),
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      const SizedBox(height: 25),
                      enterFirstBodyInput(
                          context: context,

                          ),
                      const SizedBox(height: 20),
                      forgotPassword(
                          context: context,
                         ),
                      const SizedBox(height: 20),

                      const SizedBox(height: 20),
                      enterButton(
                          context: context,
                         )
                    ],
                  ),
                ),
              ))),
      onWillPop: () async {

        box.delete("langLock");
        box.put("langLock", "1");
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     CupertinoPageRoute(
        //         builder: (context) =>  MainPages(homeIdMainpage: "0",)),
        //         (route) => false);
        return true;
      },
    );
  }
}
