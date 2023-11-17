import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/view/page_0_root/lang_choose.dart';
import 'package:shopping/view/page_5_account/chat_page/chat_pages.dart';
import 'package:shopping/view/page_5_account/information_page/information_pages.dart';
import 'package:easy_localization/easy_localization.dart';

Widget serviceAccountPage({required BuildContext context}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ListTile(
        onTap: () {
          pushNewScreen(context,
              screen: InformationPages(), withNavBar: false);
        },
        leading: const Icon(CupertinoIcons.question_circle,
            color: Colors.black),
        title: Text(
          "information".tr(),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: Colors.black, size: 20),
      ),
      ListTile(
        leading: const Icon(Icons.phone, color: Colors.black),
        title: Text(
          "telephone".tr(),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          "+998 99 123 45 67",
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: Colors.black, size: 20),
      ),
      ListTile(
        onTap: () {
          pushNewScreen(context,
              screen: ChatPage(), withNavBar: false);
        },
        leading: const Icon(Icons.local_post_office_outlined,
            color: Colors.black),
        title: Text(
          "connectWithUs".tr(),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: Colors.black, size: 20),
      ),
      ListTile(
        onTap: () {
          pushNewScreen(context,
              screen: EnterFirst0(windowId: "1"), withNavBar: false);
        },
        leading: const Icon(Icons.language, color: Colors.black),
        title: Text(
          "languageApp".tr(),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: Colors.black, size: 20),
      ),
    ],
  );
}