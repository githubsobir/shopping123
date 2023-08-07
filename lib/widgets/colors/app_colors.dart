import 'dart:math';
import 'package:flutter/material.dart';

class MyColors {

  static Color appColorWhite() {
    return Colors.white;
  }

  static Color appColorGrey100() {
    return Colors.grey.shade100;
  }

  static Color appColorGrey400() {
    return Colors.grey.shade400;
  }



  static Color appColorGrey600() {
    return Colors.grey.shade600;
  }

  static Color appColorRed() {
    return Colors.red;
  }

  static Color appColorRed2() {
    return const Color.fromRGBO(253, 32, 2, 0.7);
  }

  static Color appColorBlack() {
    return Colors.black;
  }

  // rgba(229, 229, 229, 1)
  static Color appColorTextFormField1() {
    return const Color.fromRGBO(236, 242, 247, 1);
  }

  static Color appColorBlue1() {
    return const Color.fromRGBO(51, 110, 100, 1);
  }

  static Color appColorBlue2() {
    return const Color.fromRGBO(79, 149, 232, 1);
  }

  static Color appColorBackGC1() {
    return const Color.fromRGBO(255, 255, 255, 1);
  }

  static Color appColorBackGC2() {
    return const Color.fromRGBO(255, 255, 255, 1);
  }

  static Color appColorBackGC3() {
    return const Color.fromRGBO(242, 245, 253, 1);
  }

  static Color appColorBackC4() {
    return const Color.fromRGBO(48, 192, 192, 1);
  }

  static Color appColorBackC5() {
    return const Color.fromRGBO(48, 192, 192, 1);
  }

  static Color appColorGreen1() {
    return  Colors.teal;
  }

  static Color appColorGreen2() {
    return const Color(0xFF66BB6A);
  }

  static Color appColorUzBazar() {
    return  Colors.red.shade400;
    // return const Color.fromRGBO(51, 110, 100,1);
  }



  Random random = Random();



  List<Color> myColors = [
    const Color.fromRGBO(254, 246, 225, 1),
    const Color.fromRGBO(232, 247, 244, 1),
    const Color.fromRGBO(232, 247, 244, 1),
    Colors.blue.withOpacity(0.7),
    Colors.green.withOpacity(0.7),
    Colors.yellow.withOpacity(0.7),
    Colors.brown.withOpacity(0.7),
    Colors.deepPurple.withOpacity(0.7),
    Colors.deepPurpleAccent.withOpacity(0.7),
    Colors.amber.withOpacity(0.7),
    Colors.tealAccent.withOpacity(0.7)
  ];

  Color randomColor() {
    return myColors[random.nextInt(10)];
  }
}

class MyStyle {
  AnimationController? animationController;

  static TextStyle appTextStyle({double? fSize}) {
    return TextStyle(
        color: MyColors.appColorBlack(),
        fontSize: fSize!,
        fontWeight: FontWeight.w600);
  }
}
