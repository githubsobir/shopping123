import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/view/page_0_root/controller_root_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/controller_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/mini_details/controller_mini_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/mini_details/mini_details.dart';
import 'package:shopping/view/page_5_account/identification_page/enter_first/enter_first.dart';
import 'package:shopping/view/page_5_account/identification_page/sign_up/sign_up.dart';
import 'package:shopping/widgets/colors/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class MyWidgets {
  static Text robotoFontText(
      {required String text,
      double? textSize,
      Color? textColor,
      FontWeight? textFontWeight}) {
    return Text(
      text,
      style: TextStyle(
          color: textColor ?? MyColors.appColorBlack(),
          fontSize: textSize ?? 17,
          fontWeight: textFontWeight ?? FontWeight.normal,
          fontFamily: 'Roboto-Medium'),
    );
  }

  /// xatoliklarni chiqarish
  static bottomSheetUniversal(
 {required String text,
      required BuildContext context,
      } ) {
    AwesomeDialog(context: context,

    title: "UZBEK BAZAR",
      desc: text,
      dialogType: DialogType.noHeader,
      btnOkOnPress: (){},
      btnOkColor: Colors.red,
      btnOkText: "ok".tr(),
      buttonsBorderRadius: BorderRadius.circular(10)
    ).show();

    // showModalBottomSheet(
    //   context: context,
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    //   backgroundColor: Colors.white,
    //   builder: (context) {
    //     return Container(
    //         height: MediaQuery.of(context).size.height * 0.2,
    //         margin: const EdgeInsets.all(10),
    //         decoration: BoxDecoration(
    //             color: Colors.white, borderRadius: BorderRadius.circular(10)),
    //         child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //
    //               children: [
    //                 Row(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     const Text("", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    //                     const Text("UZEKBAZAR", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    //                      IconButton(icon: const Icon( Icons.cancel), onPressed: (){
    //                      Navigator.of(context).pop();
    //                     },)
    //                   ],
    //                 ),
    //                 const SizedBox(height: 20),
    //                 Text(text, style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 18 ), textAlign: TextAlign.center),
    //               ],
    //             )));
    //   },
    // ).then((value) {});
  }

  /// productni karzinkaga saqlash
  static bottomSheetDetails(
      {required String idProduct,
      required bool isFavourite,
      required BuildContext context,
      required WidgetRef ref}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  MiniDetails(idProduct: idProduct, isFavourite: isFavourite),
            ));
      },
    ).then((value) {
      ref.read(boolHideNavBar.notifier).state = false;
      ref.watch(countMiniDetails.notifier).state = 1;
      ref.read(selectColorMiniDetails.notifier).state = -1;
      ref.read(selectSizeMiniDetails.notifier).state = -1;
      ref.read(noSelectSizeMiniDetails.notifier).state = 0;
      ref.read(noSelectColorMiniDetails.notifier).state = 0;
      ref.read(sizeSelectProduct.notifier).state = "";
      ref.read(colorSelectProduct.notifier).state = "";
      ref.read(productId.notifier).state = "";
      ref.read(colorId.notifier).state = "";
      ref.read(sizeId.notifier).state = "";
    });
  }

  /// default qiymar details page

  static getDefaultStateDetailPage({required WidgetRef ref}) {
    ref.read(countMiniDetailsPage.notifier).state = 1;
    ref.read(selectColorMiniDetailsPage.notifier).state = -1;
    ref.read(selectSizeMiniDetailsPage.notifier).state = -1;
    ref.read(noSelectColorMiniDetailsPage.notifier).state = -1;
    ref.read(noSelectSizeMiniDetailsPage.notifier).state = -1;
    ref.read(sizeSelectProductPage.notifier).state = "";
    ref.read(colorSelectProductPage.notifier).state = "";
  }

  /// Phone code check
  static List<String> checkTelephoneCompanyCode = [
    "33",
    "50",
    "55",
    "77",
    "88",
    "90",
    "91",
    "93",
    "94",
    "95",
    "97",
    "98",
    "99"
  ];

  static dialogNoToken({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text("Uzbek Bazar",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          const Text(
            "Xizmatdan foydalanish uchun ro'yxatdan o'ting yoki login / parol orqali kiring",
            style: TextStyle(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          MaterialButton(
            height: 50,
            color: Colors.white,
            elevation: 0.7,
            minWidth: double.infinity,
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => EnterFirst(windowIdEnterFirst: "1"),
                  ));
            },
            child: const Text("Login / parol orqali kirish"),
          ),
          const SizedBox(height: 15),
          const Align(
              alignment: Alignment.center,
              child: Text("- YOKI -", textAlign: TextAlign.center)),
          const SizedBox(height: 15),
          MaterialButton(
            minWidth: double.infinity,
            height: 50,

            color: Colors.grey.shade200,
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SignUp(),
                  ));
            },
            child: const Text(
              "Ro'yxatdan o'tish",
            ),
          ),
        ],
      ),
    );
  }

  static String returnPhoneFormat({required String phoneNumber}) {
    String p = "(${phoneNumber.substring(0, 2)})-";
    String h = "${phoneNumber.substring(2, 5)}-";
    String o = "${phoneNumber.substring(5, 7)}-";
    String n = phoneNumber.substring(7, 9);
    return p + h + o + n;
  }
}
