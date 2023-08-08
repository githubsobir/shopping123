// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
import 'package:shopping/widgets/colors/app_colors.dart';

class ResetPasswords extends StatefulWidget {


  ResetPasswords({Key? key})
      : super(key: key);

  @override
  State<ResetPasswords> createState() => _ResetPasswordsState();
}

class _ResetPasswordsState extends State<ResetPasswords> {
  @override
  initState() {
    getPhoneNum();
    super.initState();
  }

  Future getPhoneNum() async {

  }

  final formKeyChangePasswords = GlobalKey<FormState>();
  TextEditingController textPhoneChangePassport = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.appColorWhite(),
      appBar: AppBar(
          iconTheme: IconThemeData(color: MyColors.appColorBlack()),
          elevation: 0,
          backgroundColor: MyColors.appColorWhite()),
      body: Form(
        key: formKeyChangePasswords,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    MyWidgets.robotoFontText(
                        text: "changePassport".tr(), textSize: 24),
                    const SizedBox(height: 10),
                    TextFormField(
                        controller:
                          textPhoneChangePassport,
                        maxLines: 1,
                        textAlignVertical: TextAlignVertical.center,
                        maxLength: 9,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'\d')),
                        ],
                        decoration: InputDecoration(
                          prefixText: "+998 ",
                          suffixIcon: GestureDetector(
                            child: const Icon(Icons.clear, size: 12),
                            onTap: () {
                 textPhoneChangePassport
                                  .clear();
                            },
                          ),
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
                            if (value!.length > 1) {
                              String kod = value.substring(0, 2);
                              for (var element
                                  in MyWidgets.checkTelephoneCompanyCode) {
                                if (element.contains(kod)) {

                                  break;
                                } else {

                                }
                              }
                              // if (!widget.providerEnterFirst.myBoolWidget &&
                              //     value.length < 3) {
                              //   return "kodError".tr();
                              // } else {
                              //   return "kodLength".tr();
                              // }
                            } else {
                              return "kodError".tr();
                            }
                          } else {
                            // String kod = value.substring(0, 2);
                            // for (var element
                            //     in MyWidgets.checkTelephoneCompanyCode) {
                            //   if (element.contains(kod)) {
                            //     widget.providerEnterFirst.myBoolWidget = true;
                            //     widget.providerEnterFirst
                            //         .boolButtonCol1(boolValue: true);
                            //     break;
                            //   } else {
                            //     widget.providerEnterFirst
                            //         .boolButtonCol1(boolValue: false);
                            //     widget.providerEnterFirst.myBoolWidget = false;
                            //   }
                            // }
                            // if (!widget.providerEnterFirst.myBoolWidget) {
                            //   widget.providerEnterFirst
                            //       .boolButtonCol1(boolValue: false);
                            //   return "kodError".tr();
                            // } else {
                            //   widget.providerEnterFirst
                            //       .boolButtonCol1(boolValue: true);
                            // }
                          }
                          return null;
                        }),
                    const SizedBox(height: 20),

                    const SizedBox(height: 20),
                    MaterialButton(
                        onPressed: () {
                          // if (widget.providerEnterFirst.textPhoneChangePassport
                          //         .text.length == 9 &&
                          //     widget.providerEnterFirst
                          //         .textCaptchaEditingController.text.isNotEmpty) {
                          //
                          //   if(widget.providerEnterFirst.formKeyChangePasswords.currentState!.validate()){
                          //
                          //     widget.providerEnterFirst.getNewPassport(
                          //       context: context,
                          //       captchaVal: widget.providerEnterFirst
                          //           .textCaptchaEditingController.text,
                          //       phoneNumber: widget.providerEnterFirst
                          //           .textPhoneChangePassport.text,
                          //     );
                          //     //
                          //   }else{
                          //     MyWidgets.scaffoldMessengerBottom(
                          //         context: context, valueText: "infoNotAll".tr());
                          //   }
                          //
                          //
                          // } else {
                          //   MyWidgets.scaffoldMessengerBottom(
                          //       context: context, valueText: "infoNotAll".tr());
                          // }
                        },
                        height: 50,
                        minWidth: double.infinity,
                        color: MyColors.appColorUzBazar(),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: MyWidgets.robotoFontText(
                            text: "access".tr(),
                            textColor: MyColors.appColorWhite()))
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
