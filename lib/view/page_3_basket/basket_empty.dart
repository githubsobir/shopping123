import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Widget basketEmpty({required BuildContext context}){
  return  Center(child: Text("infoNotFind".tr(),
    style: const TextStyle(
     ),));
}