// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/view/page_5_account/identification_page/enter_first/app_bar.dart';
import 'package:shopping/view/page_5_account/identification_page/enter_first/controller_login.dart';
import 'package:shopping/view/page_5_account/identification_page/enter_first/enter_button.dart';
import 'package:shopping/view/page_5_account/identification_page/enter_first/forgot_pasword.dart';
import 'package:shopping/view/page_5_account/identification_page/enter_first/inputs.dart';
import 'package:shopping/widgets/colors/app_colors.dart';

class EnterFirst extends ConsumerStatefulWidget {
  String windowIdEnterFirst = "";

  EnterFirst({Key? key, required this.windowIdEnterFirst}) : super(key: key);

  @override
  ConsumerState<EnterFirst> createState() => _EnterFirstState();
}

class _EnterFirstState extends ConsumerState<EnterFirst> {
  // var box = Hive.box("online");

  bool boolPasswordVisible = true;
  final formKey = GlobalKey<FormState>();
  bool myBoolWidget = false;
  bool boolButtonColor1 = false;
  TextEditingController textAuthLogin = TextEditingController();
  TextEditingController textAuthPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.watch(checkSignIn);
    return Scaffold(
        backgroundColor: MyColors.appColorWhite(),
        appBar: enterFirstAppBar(context: context),
        body:
        ref.watch(checkSignIn).boolGetData ?
        Center(
            child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Image.asset("assets/images/shopping1.png", height: 100),
                  const SizedBox(height: 10),
                  Text(
                    "UzBazar",
                    style: TextStyle(
                        color: MyColors.appColorUzBazar(),
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  const SizedBox(height: 40),
                  enterFirstBodyInput(
                    context: context,
                  ),
                  const SizedBox(height: 20),
                  forgotPassword(
                    context: context,
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  // enterButton(
                  //   context: context,
                  // )
                ],
              ),
            ),
          ),
        ))
    :const Center(child: CupertinoActivityIndicator(),)
    );
  }
}
