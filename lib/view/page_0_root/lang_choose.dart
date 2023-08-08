import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping/view/page_0_root/root_page.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
import 'package:shopping/widgets/colors/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class EnterFirst0 extends StatefulWidget {
  const EnterFirst0({Key? key}) : super(key: key);

  @override
  State<EnterFirst0> createState() => _EnterFirst0State();
}

var box = Hive.box("online");

class _EnterFirst0State extends State<EnterFirst0> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.appColorWhite(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/shopping1.png",
                            height: 110, fit: BoxFit.cover),
                        const SizedBox(width: 10),
                        MyWidgets.robotoFontText(
                            text: "UzBazar",
                            textColor: MyColors.appColorBlack(),
                            textFontWeight: FontWeight.bold,
                            textSize: 28)
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "chooseLang".tr(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter-Medium",
                          fontSize: 20),
                    ),
                    const SizedBox(height: 15),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        textColor: MyColors.appColorBlack(),
                        title: MyWidgets.robotoFontText(
                            text: "uz".tr(), textFontWeight: FontWeight.w400),
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage("assets/images/uz.png"),
                          radius: 15,
                        ),
                        trailing: const Icon(CupertinoIcons.chevron_forward),
                        onTap: () {
                          box.delete("language");
                          box.put("language", "1");
                          context.setLocale(const Locale('uz', 'UZ'));
                          // context.locale = const Locale("uz", "UZ");
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    RootPage(homeIdMainpage: "0"),
                              ));
                        },
                      ),
                    ),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        textColor: MyColors.appColorBlack(),
                        title: MyWidgets.robotoFontText(
                            text: "English language",
                            textFontWeight: FontWeight.w400),
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage("assets/images/ukflag.png"),
                          radius: 15,
                        ),
                        trailing: const Icon(CupertinoIcons.chevron_forward),
                        onTap: () {
                          box.delete("language");
                          box.put("language", "2");
                          context.setLocale(const Locale('en', 'EN'));
                          // context.locale = const Locale("kk", "KK");
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    RootPage(homeIdMainpage: "0"),
                              ));
                        },
                      ),
                    ),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        textColor: MyColors.appColorBlack(),
                        title: MyWidgets.robotoFontText(
                            text: "Русский язык",
                            textFontWeight: FontWeight.w400),
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage("assets/images/ru.png"),
                          radius: 15,
                        ),
                        trailing: const Icon(CupertinoIcons.chevron_forward),
                        onTap: () {
                          box.delete("language");
                          box.put("language", "3");
                          context.setLocale(const Locale('ru', 'RU'));
                          // context.locale = const Locale("ru", "RU");
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    RootPage(homeIdMainpage: "0"),
                              ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
