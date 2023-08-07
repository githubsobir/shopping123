import 'package:flutter/material.dart';
import 'package:shopping/widgets/colors/app_colors.dart';

PreferredSizeWidget enterFirstAppBar(
    {required BuildContext context,
   }) {
  return AppBar(
    elevation: 0,
    toolbarHeight: 45,
    backgroundColor: MyColors.appColorWhite(),
    iconTheme: IconThemeData(color: MyColors.appColorBlack()),
  );
}
