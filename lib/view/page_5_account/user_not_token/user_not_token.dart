import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Widget userNotTokenUI(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 180,
        // padding: const EdgeInsets.all(10),
        decoration:  BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 2),
            image: const DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage(
                "assets/images/shopping1.png",
              ),
            )),

      ),
      const SizedBox(height: 15),
      Text(
        "loginCabinet".tr(),
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 20),
    ],
  );
}