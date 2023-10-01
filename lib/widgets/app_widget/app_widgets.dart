import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/view/page_0_root/controller_root_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/controller_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/mini_details/controller_mini_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/mini_details/mini_details.dart';
import 'package:shopping/widgets/colors/app_colors.dart';

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

 static bottomSheetDetails(
      {required String idProduct,
      required bool isFavourite,
      required BuildContext context,
      required WidgetRef ref}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      builder: (
        context,
      ) {
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
    });
  }

  /// default qiymar details page

  static getDefaultStateDetailPage ({required WidgetRef ref}){
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

  static String returnPhoneFormat({required String phoneNumber}) {
    String p = "(${phoneNumber.substring(0, 2)})-";
    String h = "${phoneNumber.substring(2, 5)}-";
    String o = "${phoneNumber.substring(5, 7)}-";
    String n = phoneNumber.substring(7, 9);
    return p + h + o + n;
  }
}
