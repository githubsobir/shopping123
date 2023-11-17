import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

Widget userWithTokenUI() {
  var box = Hive.box("online");
  // box.delete("userId");
  // box.delete("userName");
  // box.delete("userPhone");
  // box.delete("userAvatar");
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 180,
            width: 180,
            // padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.grey, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                  height: 160,
                  width: 160,
                  fit: BoxFit.cover,

                  imageUrl: box.get("userAvatar").toString()),
            ),
          ),
        ],
      ),
      const SizedBox(height: 15),
      Text(
        box.get("userName").toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 20),
      Divider(),

    ],
  );
}
