import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/view/page_0_root/lang_choose.dart';
import 'package:shopping/view/page_5_account/chat_page/chat_pages.dart';
import 'package:shopping/view/page_5_account/identification_page/enter_first/enter_first.dart';
import 'package:shopping/view/page_5_account/information_page/information_pages.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "personalCabinet".tr(),
            style: const TextStyle(color: Colors.black),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                ListTile(
                  onTap: (){
                    pushNewScreen(context, screen: InformationPages(),
                        withNavBar: false
                    );
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
                  leading: const Icon(Icons.phone,
                      color: Colors.black),
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
                  onTap: (){
                    pushNewScreen(context, screen: ChatPage(),
                    withNavBar: false
                    );
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
                  onTap: (){
                    pushNewScreen(context, screen: EnterFirst0(windowId: "1"),
                    withNavBar: false
                    );
                  },
                  leading: const Icon(Icons.language,
                      color: Colors.black),
                  title: Text(
                    "languageApp".tr(),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Colors.black, size: 20),
                ),
                const SizedBox(height: 40),
                Align(
                    alignment: Alignment.bottomCenter,

                    child: MaterialButton(
                        color: Colors.grey.shade50,
                        height: 45,
                        minWidth: MediaQuery.of(context).size.width*0.5,
                        onPressed: (){
                          pushNewScreen(context, screen: EnterFirst(windowIdEnterFirst: "0"),
                              withNavBar: false
                          );

                        },child: Text("Kirish"))),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
