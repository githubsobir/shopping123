// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:animated_introduction/animated_introduction.dart';
import 'package:connection_notifier/connection_notifier.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shopping/view/page_0_root/lang_choose.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(milliseconds: 1900));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.removeAfter(initialization);
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Hive.initFlutter();
  await Hive.openBox("online");
  await initialization(null);
  // final config = TalsecConfig(
  //   /// For Android
  //   androidConfig: AndroidConfig(
  //     packageName: 'www.uzbmba.uz',
  //     signingCertHashes: [
  //       'bNSrT49K4aceo7I8iMlohhDtRS0e7kcGeMiH4jSKYaE='
  //     ],
  //     supportedStores: ['some.other.store'],
  //   ),
  //   watcherMail: 'tojiyev.s.b@gmail.com',
  //   isProd: true,
  // );
  // final callback = ThreatCallback(
  //     onAppIntegrity: () => print("App integrity"),
  //     onObfuscationIssues: () => print("Obfuscation issues"),
  //     onDebug: () => print("Debugging"),
  //     onDeviceBinding: () => print("Device binding"),
  //     onDeviceID: () => print("Device ID"),
  //     onHooks: () => print("Hooks"),
  //     onPasscode: () => print("Passcode not set"),
  //     onPrivilegedAccess: () => print("Privileged access"),
  //     onSecureHardwareNotAvailable: () => print("Secure hardware not available"),
  //     onSimulator: () => print("Simulator"),
  //     onUnofficialStore: () => print("Unofficial store")
  // );
  //
  // // Attaching listener
  // Talsec.instance.attachListener(callback);
  //
  //
  // await Talsec.instance.start(config);
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
    return ConnectionNotifier(
      disconnectedContent: const Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.signal_wifi_connected_no_internet_4),
          SizedBox(width: 10),
          Text("Internet", style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      )),
      connectedContent: const Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.check_mark_circled_solid),
          SizedBox(width: 10),
          Text("Internet", style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      )),
      child: MaterialApp(
          navigatorKey: navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          home: box.get("language") == "1" ||
                  box.get("language") == "2" ||
                  box.get("language") == "3"
              ? //MainPages()//
          EnterFirst0()//RootPage(homeIdMainpage: "1")
              : const EnterFirst0()),
    );
  }
}

final List<SingleIntroScreen> pages = [
  const SingleIntroScreen(
    title: 'Welcome to the Event Management App !',
    description:
        'You plans your Events, We\'ll do the rest and will be the best! Guaranteed!  ',
    imageAsset: 'assets/image1.jpeg',
  ),
  const SingleIntroScreen(
    title: 'Book tickets to cricket matches and events',
    description:
        'Tickets to the latest movies, crickets matches, concerts, comedy shows, plus lots more !',
    imageAsset: 'assets/image2.png',
  ),
  const SingleIntroScreen(
    title: 'Grabs all events now only in your hands',
    description: 'All events are now in your hands, just a click away ! ',
    imageAsset: 'assets/image1.jpeg',
  ),
];

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedIntroduction(
      footerPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      slides: pages,
      footerRadius: 10,
      indicatorType: IndicatorType.diamond,
      onDone: () {
        /// TODO: Go to desire page like login or home
      },
      isFullScreen: false,

    );
  }
}
