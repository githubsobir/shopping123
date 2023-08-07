// import 'package:flutter/cupertino.dart';
// import 'package:mydtm/data/internet_connections/m1_internet/get_captcha.dart';
// import 'package:mydtm/data/model_parse/m1_model/parse_captche.dart';
// import 'package:mydtm/view/widgets/app_widget/sms_auto_fill/ui/s3_body_sms_auto_fill.dart';
// import 'dart:developer';
// class ProviderSignUp extends ChangeNotifier {
//   ///# offline
//   final formKey = GlobalKey<FormState>();
//   bool myBoolWidget = false;
//   TextEditingController textSingUpLogin = TextEditingController();
//   TextEditingController textSingUpPassword = TextEditingController();
//
//   bool boolButtonColor1 = false;
//
//   Future boolButtonCol1({required bool boolValue}) async {
//     boolButtonColor1 = boolValue;
//   }
//
//   bool boolButtonColor2 = false;
//
//   Future boolButtonCol2({required bool boolValue}) async {
//     boolButtonColor2 = boolValue;
//   }
//
//   bool boolPasswordVisible = true;
//
//   Future boolPasswordVisibleMethod() async {
//     boolPasswordVisible = !boolPasswordVisible;
//     notifyListeners();
//   }
//
//   ///#
//
//   ///#online
//   ///#1 Captcha
//   late ModelParseCaptcha modelParseCaptcha;
//   TextEditingController textCaptchaSignUpController = TextEditingController();
//   bool boolGetCaptcha = false;
//
//   Future getCaptcha() async {
//     try {
//       boolGetCaptcha = false;
//       modelParseCaptcha = await NetworkGetCaptcha.getCaptcha();
//       boolGetCaptcha = true;
//       notifyListeners();
//     } catch (e) {
//       /// error
//     }
//   }
//
//   ///#1
//
//   ///#2 Registration
//   Future getRegistration({required BuildContext context}) async {
//     try {
//     getCaptcha();
//       Navigator.push(
//           context,
//           CupertinoPageRoute(
//             builder: (context) => SmsAutoFillUi(
//                 phoneNum: textSingUpLogin.text,
//                 password: textSingUpPassword.text,
//                 captchaKey: modelParseCaptcha.data.captchaKey,
//                 captchaValue: textCaptchaSignUpController.text,
//                 registration: "1"),
//           ));
//       // textCaptchaSignUpController.clear();
//     } catch (e) {
//       log(e.toString());
//     }
//   }
//
//   ///#
// }
