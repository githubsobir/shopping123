// // ignore_for_file: use_build_context_synchronously
//
// import 'dart:convert';
// import 'dart:developer';
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_pw_validator/Resource/MyColors.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:mydtm/data/internet_connections/m1_internet/authorize.dart';
// import 'package:mydtm/data/internet_connections/m1_internet/get_captcha.dart';
// import 'package:mydtm/data/internet_connections/m1_internet/get_token.dart';
// import 'package:mydtm/data/internet_connections/m6_profile/change_password.dart';
// import 'package:mydtm/data/internet_connections/m6_profile/sms_model_reset_pass.dart';
// import 'package:mydtm/data/model_parse/m1_model/authhorization/model_auth_token.dart';
// import 'package:mydtm/data/model_parse/m1_model/authhorization/model_auth_captcha_error.dart';
// import 'package:mydtm/data/model_parse/m1_model/authhorization/model_auth_error.dart';
// import 'package:mydtm/data/model_parse/m1_model/authhorization/model_auth_success.dart';
// import 'package:mydtm/data/model_parse/m1_model/authhorization/model_get_token.dart';
// import 'package:mydtm/data/model_parse/m1_model/parse_captche.dart';
// import 'package:mydtm/view/pages/m1_enter_system/sign_up/model_sign_up.dart';
// import 'package:mydtm/view/pages/m2_main_page/main_page.dart';
// import 'package:mydtm/view/widgets/app_widget/app_widgets.dart';
// import 'package:mydtm/view/widgets/app_widget/sms_auto_fill/model/model_captcha_error.dart';
// import 'package:mydtm/view/widgets/app_widget/sms_auto_fill/ui/s3_body_sms_auto_fill.dart';
// import 'package:ntp/ntp.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
//
// class ProviderEnterFirst extends ChangeNotifier {
//   ///#offline App Logic
//   bool boolPasswordVisible = true;
//   final formKey = GlobalKey<FormState>();
//   bool myBoolWidget = false;
//   bool boolButtonColor1 = false;
//   TextEditingController textAuthLogin = TextEditingController();
//   TextEditingController textAuthPassword = TextEditingController();
//
//   Future boolButtonCol1({required bool boolValue}) async {
//     boolButtonColor1 = boolValue;
//   }
//
//   Future boolPasswordVisibleMethod() async {
//     boolPasswordVisible = !boolPasswordVisible;
//     notifyListeners();
//   }
//
//   Future enterSignUp({required BuildContext context}) async {
//     Navigator.push(
//         context,
//         CupertinoPageRoute(
//           builder: (context) => const SignUp(),
//         ));
//   }
//
//   // Future enterPersonPassport({required BuildContext context}) async {
//   //
//   //
//   //   Navigator.push(
//   //       context,
//   //       CupertinoPageRoute(
//   //         builder: (context) => PersonInformation(),
//   //       ));
//   // }
//
//   /// #offline
//
//   /// App with internet
//
//   /// #0 captcha
//   late ModelParseCaptcha modelParseCaptcha;
//   TextEditingController textCaptchaEditingController = TextEditingController();
//   bool boolGetCaptcha = false;
//
//   Future getCaptcha() async {
//     try {
//       box.get("clothe5Min").toString() == "1"
//           ? mainNtp()
//           : box.get("clothe5Min").toString() == "2"
//               ? mainNtp()
//               : {
//                   boolGetCaptcha = false,
//                   modelParseCaptcha = await NetworkGetCaptcha.getCaptcha(),
//                   boolGetCaptcha = true,
//                   notifyListeners(),
//                 };
//     } catch (e) {
//       /// error
//     }
//   }
//
//   /// #0
//
//   /// #1 Authorization
//   late ModelAuthorizationParse modelAuthorizationParse;
//   late ModelErrorUserName modelAuthorizationError;
//   late ModelAuthorizationCaptchaError modelAuthorizationCaptchaError;
//
//   bool boolAuthorization = false;
//
//   ///
//   var box = Hive.box("online");
//   String dataData = "";
//
//   Future getAuthorization({required BuildContext context}) async {
//     boolAuthorization = false;
//     Map<String, String> getAuthorizationData = {
//       "username": textAuthLogin.text.trim(),
//       "password": textAuthPassword.text.trim(),
//       "captcha_key": modelParseCaptcha.data.captchaKey,
//       "captcha_val": textCaptchaEditingController.text.trim(),
//       "app_id": "1"
//     };
//     if (box.get("clothe5Min") == "1") {
//       mainNtp();
//     }
//
//     try {
//       boolAuthorization = true;
//       notifyListeners();
//       dataData = await NetworkAuthorize.getAuthorize(
//           mapAuthorize: getAuthorizationData);
//       log(dataData);
//       ModelUserToken modelUserToken =
//           ModelUserToken.fromJson(jsonDecode(dataData));
//       String token = await NetworkGetToken.getTokenModel(
//           authCode: modelUserToken.data.authorizationCode);
//       ModelGetToken modelGetToken = ModelGetToken.fromJson(jsonDecode(token));
//
//       box.put("token", modelGetToken.data.accessToken);
//       log(box.get("token"));
//       if (box.get("token").toString().length > 30) {
//         box.delete("phoneNumber");
//         box.put("phoneNumber", textAuthLogin.text);
//         box.delete("langLock");
//         box.put("langLock", "1");
//
//         ///
//         box.put("clothe5Min", "0");
//         box.put("errorTry", "0");
//       }
//       AwesomeDialog(
//           context: context,
//           titleTextStyle: const TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.blueAccent,
//           ),
//           dismissOnTouchOutside: false,
//           dismissOnBackKeyPress: false,
//           dialogType: DialogType.noHeader,
//           body: SizedBox(
//             height: 180,
//             child: Column(
//               children: [
//                 const Text(
//                   "BBA",
//                   style: TextStyle(
//                       color: Color.fromRGBO(51, 110, 100, 1),
//                       fontWeight: FontWeight.bold,
//                       fontSize: 24),
//                 ),
//                 const SizedBox(height: 20),
//                 Center(
//                   child: const Icon(
//                     Icons.check_circle,
//                     color: Color.fromRGBO(51, 110, 100, 1),
//                     size: 60,
//                   )
//                       .animate(
//                           onPlay: (controller) =>
//                               controller.repeat(reverse: true))
//                       .scaleXY(
//                           end: 2.2,
//                           delay: const Duration(milliseconds: 600),
//                           curve: Curves.easeInOutCirc)
//                       .shimmer(
//                           color: Colors.lightBlue,
//                           delay: const Duration(milliseconds: 600))
//                       .elevation(end: 0),
//                 ),
//               ],
//             ),
//           )).show().then(
//         (value) {
//           Navigator.pushAndRemoveUntil(
//               context,
//               CupertinoPageRoute(
//                 builder: (context) => MainPages(homeIdMainpage: "1"),
//               ),
//               (route) => false);
//         },
//       );
//       await Future.delayed(const Duration(milliseconds: 900)).then(
//         (value) {
//           Navigator.of(context).pop();
//         },
//       );
//
//       boolAuthorization = false;
//       modelAuthorizationParse =
//           ModelAuthorizationParse.fromJson(jsonDecode(dataData));
//
//       notifyListeners();
//     } catch (e) {
//       getCaptcha();
//       if (box.get("errorTry") == null || box.get("errorTry") == "0") {
//         box.put("errorTry", "1");
//       } else if (box.get("errorTry") == "1") {
//         box.put("errorTry", "2");
//       } else if (box.get("errorTry") == "2") {
//         box.put("errorTry", "3");
//       } else if (box.get("errorTry") == "3") {
//         box.put("clothe5Min", "1");
//         mainNtp();
//       }
//
//       try {
//         boolAuthorization = false;
//         modelAuthorizationError =
//             ModelErrorUserName.fromJson(jsonDecode(dataData));
//         MyWidgets.scaffoldMessengerBottom(
//             context: context, valueText: "loginPasswordError".tr());
//       } catch (e) {
//         try {
//           boolAuthorization = false;
//           modelAuthorizationCaptchaError =
//               ModelAuthorizationCaptchaError.fromJson(jsonDecode(dataData));
//           MyWidgets.scaffoldMessengerBottom(
//               context: context, valueText: "captchaError".tr());
//         } catch (e) {
//           // smsId: widget.captchaValue, endTime: int.parse(widget.captchaKey), context: context);
//           log(jsonDecode(dataData).toString());
//           // ModelRegistrationSms modelRegistrationSms =
//           //     ModelRegistrationSms.fromJson(jsonDecode(dataData));
//
//           log(dataData);
//           log("::");
//           MyWidgets.scaffoldMessengerBottom(
//               context: context, valueText: "loginPasswordError".tr());
//           // pushNewScreen(context,
//           //     pageTransitionAnimation: PageTransitionAnimation.cupertino,
//           //     screen: SmsAutoFillUi(
//           //         phoneNum: textAuthLogin.text,
//           //         password: textAuthPassword.text,
//           //         captchaKey: modelRegistrationSms.data.endDate.toString(),
//           //         captchaValue: modelRegistrationSms.data.smsId.toString(),
//           //         registration: "99"));
//         }
//       }
//     }
//     notifyListeners();
//   }
//
//   /// #1
//
//   TextEditingController textPhoneChangePassport = TextEditingController();
//   final formKeyChangePasswords = GlobalKey<FormState>();
//   NetworkChangePassword networkChangePassword = NetworkChangePassword();
//   late String dataNetChangePhoneNumber;
//
//   Future getNewPassport({
//     required BuildContext context,
//     required String phoneNumber,
//     required String captchaVal,
//   }) async {
//     Map<String, dynamic> mapForNewPassword = {
//       "username": phoneNumber,
//       "captcha_key": modelParseCaptcha.data.captchaKey.toString(),
//       "captcha_val": captchaVal,
//     };
//
//     try {
//       log("captche key 2 si");
//       log(jsonEncode(mapForNewPassword).toString());
//       log("mapp pasti 3 si");
//       dataNetChangePhoneNumber = await networkChangePassword
//           .getChangePhoneNumber(mapChangePassword: mapForNewPassword);
//       ModelResetPassSms modelResetPassSms =
//           ModelResetPassSms.fromJson(jsonDecode(dataNetChangePhoneNumber));
//       textCaptchaEditingController.clear();
//       getCaptcha();
//       modelResetPassSms.status == 1
//           ? pushNewScreen(context,
//               pageTransitionAnimation: PageTransitionAnimation.cupertino,
//               screen: SmsAutoFillUi(
//                   phoneNum: phoneNumber,
//                   password: "",
//                   captchaKey: modelResetPassSms.data.smsId.toString(),
//                   captchaValue: modelResetPassSms.data.endDate.toString(),
//                   registration: "2"))
//           : {};
//       notifyListeners();
//     } catch (e) {
//       log(e.toString());
//       try {
//         textCaptchaEditingController.clear();
//
//         ModelRegistrationCaptchaError modelRegistrationCaptchaError =
//             ModelRegistrationCaptchaError.fromJson(
//                 jsonDecode(dataNetChangePhoneNumber));
//         MyWidgets.awesomeDialogInfo(
//             context: context, valueText: modelRegistrationCaptchaError.errors);
//         notifyListeners();
//       } catch (e) {
//         getCaptcha();
//         notifyListeners();
//         MyWidgets.awesomeDialogInfo(context: context, valueText: "reTry".tr());
//       }
//
//       log(e.toString());
//     }
//   }
//
//   int currentTimeHour = 0, currentTimeMinute = 0;
//
//   Future<void> mainNtp() async {
//     try {
//       DateTime myTime;
//       myTime = await NTP.now();
//       currentTimeHour = myTime.hour;
//       currentTimeMinute = myTime.minute;
//
//       if (box.get("clothe5Min") == "1") {
//         box.put("timeHour", myTime.hour.toString());
//         box.put("timeMinute", myTime.minute.toString());
//       }
//
//       log(getTimeDifferance().toString());
//       log("clothe5Min");
//       log(box.get("clothe5Min"));
//       log("timeHour");
//       log(box.get("timeHour").toString());
//       log("timeMinute");
//       log(box.get("timeMinute").toString());
//
//       log("Currernt time");
//       log(currentTimeHour.toString());
//       log(currentTimeMinute.toString());
//
//       if (getTimeDifferance() >= 5) {
//         box.put("clothe5Min", "0");
//         box.put("errorTry", "0");
//         boolGetCaptcha = false;
//         modelParseCaptcha = await NetworkGetCaptcha.getCaptcha();
//         boolGetCaptcha = true;
//         notifyListeners();
//       } else {
//         box.put("clothe5Min", "2");
//       }
//       notifyListeners();
//     } catch (e) {
//       log(e.toString());
//     }
//   }
//
//   int getTimeDifferance() {
//     return currentTimeHour - int.parse(box.get("timeHour") ?? "0".toString()) ==
//             0
//         ? currentTimeMinute - int.parse(box.get("timeMinute") ?? "0".toString())
//         : (currentTimeHour - int.parse(box.get("timeHour") ?? "0".toString())) *
//                 60 +
//             int.parse(box.get("timeMinute") ?? "0".toString()) -
//             currentTimeMinute;
//   }
// }
