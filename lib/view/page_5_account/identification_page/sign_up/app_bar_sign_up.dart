import 'package:flutter/material.dart';
import 'package:shopping/widgets/colors/app_colors.dart';

PreferredSizeWidget appBarSignUp(
    {required BuildContext context}) {
  return AppBar(
    backgroundColor: MyColors.appColorWhite(),
    elevation: 0,
    iconTheme: IconThemeData(color: MyColors.appColorBlack()),
  );
}