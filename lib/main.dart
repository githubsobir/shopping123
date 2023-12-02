  // ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping/view/page_0_root/lang_choose.dart';
import 'package:shopping/view/page_0_root/root_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(milliseconds: 100));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Hive.initFlutter();
  await Hive.openBox("online");
  await initialization(null);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (_) => runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en', 'EN'),
          Locale('ru', 'RU'),
          Locale('uz', 'UZ'),
        ],
        path: 'assets/lang',
        fallbackLocale: const Locale('uz', 'UZ'),
        child:
        ProviderScope(child: MyApp(),)

      ),
    ),
  );

}

class MyApp extends StatelessWidget {
  var box = Hive.box("online");

  MyApp({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      // ConnectionNotifier(
      // connectionNotificationOptions: ConnectionNotificationOptions(),
      // disconnectedContent: const Center(
      //     child: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Icon(Icons.signal_wifi_connected_no_internet_4),
      //     SizedBox(width: 10),
      //     Text("Internet", style: TextStyle(fontWeight: FontWeight.w600)),
      //   ],
      // )),
      // connectedContent: const Center(
      //     child: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Icon(CupertinoIcons.check_mark_circled_solid),
      //     SizedBox(width: 10),
      //     Text("Internet", style: TextStyle(fontWeight: FontWeight.w600)),
      //   ],
      // )),
      // child:
      MaterialApp(
          navigatorKey: navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          home: box.get("language") == "1" ||
                  box.get("language") == "2" ||
                  box.get("language") == "3"
              ? //MainPages()//
        RootPage(homeIdMainpage: 0)
              :  EnterFirst0(windowId: "0",)
      // ),
    );
  }
}