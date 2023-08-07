// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/view/page_1_main/main_page.dart';
import 'package:shopping/view/page_2_category/category_page.dart';
import 'package:shopping/view/page_3_basket/basket_page.dart';
import 'package:shopping/view/page_4_favourite/favourite_page.dart';
import 'package:shopping/view/page_5_account/account_page.dart';
import 'package:shopping/widgets/colors/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
class RootPage extends StatefulWidget {
  String homeIdMainpage;

  RootPage({Key? key, required this.homeIdMainpage}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  Future getBoshFunc() async {
    // await widget.providerCheckInformation.getQaydVaraqa2();
    setState(() {});
  }

  List<Widget> myPages() => [
    MainPage(),
    CategoryPage(),
    BasketPage(),
    FavouritePage(),
    AccountPage()



  ];
  int index = 0;
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  getFunction() {
    setState(() {});
  }

  var box = Hive.box("online");

  Future getFirstAction() async {
    try {
      await Future.delayed(Duration.zero);

      box.delete("updateVersion");
      box.put("updateVersion", "1005");
    } catch (e) {
      throw Exception("Error update");
    }
  }

  @override
  initState() {
    super.initState();
    // screenLock123();
    // isBiometricAvailable();
    // getFirstAction();
  }

  // Future screenLock123() async {
  //   await Future.delayed(const Duration(milliseconds: 10)).then((value) {
  //     if (box.get("langLock").toString().trim() == "1") {
  //       box.delete("langLock");
  //     } else {
  //       box.get("lockScreen").toString().trim().length == 4 &&
  //           box.get("lockScreen").toString() != "null"
  //           ? {
  //         screenLock(
  //           useBlur: true,
  //           context: navigatorKey.currentContext!,
  //           correctString: box.get("lockScreen").toString(),
  //           canCancel: false,
  //           footer: Row(
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: [
  //               GestureDetector(
  //                   onTap: () {
  //                     AwesomeDialog(
  //                       context: context,
  //                       dialogType: DialogType.noHeader,
  //                       animType: AnimType.bottomSlide,
  //                       title: "BBA",
  //                       desc: "logUot".tr(),
  //                       titleTextStyle: TextStyle(
  //                           color: MyColors.appColorBlue1(),
  //                           fontSize: 24,
  //                           fontWeight: FontWeight.bold),
  //                       descTextStyle: TextStyle(
  //                           color: MyColors.appColorBlack(),
  //                           fontSize: 18,
  //                           fontWeight: FontWeight.w500),
  //                       btnOkOnPress: () {
  //                         box.delete("token");
  //                         box.delete("imie");
  //                         box.delete("psnum");
  //                         box.delete("personImage");
  //                         box.delete("boxAllPersonInfo");
  //                         box.delete("langLock");
  //                         box.delete("lockScreen");
  //
  //                         if (Platform.isIOS) {
  //                           exit(0);
  //                         } else {
  //                           SystemNavigator.pop();
  //                         }
  //                         Navigator.of(context).pop();
  //                       },
  //                       btnOkText: "yes".tr(),
  //                       btnOkColor: MyColors.appColorGrey600(),
  //                       btnCancelColor: MyColors.appColorBBA(),
  //                       btnCancelOnPress: () {},
  //                       btnCancelText: "no".tr(),
  //                     ).show();
  //                     // AwesomeDialog(
  //                     //         context: context,
  //                     //         dialogType: DialogType.noHeader,
  //                     //         animType: AnimType.bottomSlide,
  //                     //         title: "DTM",
  //                     //         desc: "logUot".tr(),
  //                     //         titleTextStyle: TextStyle(
  //                     //             color: MyColors.appColorBlue1(),
  //                     //             fontSize: 24,
  //                     //             fontWeight: FontWeight.bold),
  //                     //         descTextStyle: TextStyle(
  //                     //             color: MyColors.appColorBlack(),
  //                     //             fontWeight: FontWeight.bold),
  //                     //         btnCancelOnPress: () {
  //                     //           if (Platform.isIOS) {
  //                     //             exit(0);
  //                     //           } else {
  //                     //             SystemNavigator.pop();
  //                     //           }
  //                     //           Navigator.of(context).pop();
  //                     //           box.delete("lockScreen");
  //                     //           box.delete("token");
  //                     //           box.delete("imie");
  //                     //           box.delete("psnum");
  //                     //           box.delete("personImage");
  //                     //           box.delete("boxAllPersonInfo");
  //                     //         },
  //                     //         btnCancelColor: MyColors.appColorBlue1(),
  //                     //         btnCancelText: "OK")
  //                     //     .show();
  //                   },
  //                   child: Text("exet".tr())),
  //               const SizedBox(width: 20),
  //             ],
  //           ),
  //           // customizedButtonChild: const Icon(
  //           //   Icons.fingerprint,
  //           // ),
  //           title: Text("pinPassword".tr()),
  //           config: const ScreenLockConfig(
  //             backgroundColor: Colors.black,
  //           ),
  //           // customizedButtonTap: () async {
  //           //   await authenticate(context: context);
  //           // },
  //           // didOpened: () async {
  //           //   await authenticate(context: context);
  //           // },
  //         ),
  //         box.delete("lockHasEnter")
  //       }
  //           : {};
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: myPages(),
      items: navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: MyColors.appColorWhite(),
      controller: controller,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: false,
      stateManagement: true,
      hideNavigationBar: false,
      hideNavigationBarWhenKeyboardShows: false,
      decoration: NavBarDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        colorBehindNavBar: MyColors.appColorBlue1(),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      navBarStyle: NavBarStyle.style3,
      // navBarStyle: NavBarStyle.style6,
    );
  }
}

List<PersistentBottomNavBarItem> navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.home,
        size: 25,
      ),
      title: "main".tr(),
      textStyle:const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      inactiveIcon: const Icon(
        Icons.home_outlined,
        size: 25,
      ),
      // title: ("Home"),
      activeColorPrimary: MyColors.appColorUzBazar(),
      activeColorSecondary:MyColors.appColorUzBazar(),
      inactiveColorPrimary: MyColors.appColorGrey400(),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
      Icons.manage_search_rounded,
        size: 25,
      ),
      title: "category".tr(),
      textStyle:const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      inactiveIcon: const Icon(
        Icons.manage_search_rounded,
        size: 25,
      ),
      activeColorPrimary: MyColors.appColorUzBazar(),
      activeColorSecondary:  MyColors.appColorUzBazar(),
      inactiveColorPrimary: MyColors.appColorGrey400(),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        CupertinoIcons.cart_fill,
        size: 25,
      ),
      title: "basket".tr(),
      textStyle:const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      inactiveIcon: const Icon(
        CupertinoIcons.cart,
        size: 25,
      ),
      activeColorPrimary:  MyColors.appColorUzBazar(),
      activeColorSecondary:  MyColors.appColorUzBazar(),
      inactiveColorPrimary: MyColors.appColorGrey400(),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.favorite,
        size: 25,
      ),
      title: "favourite".tr(),
      textStyle:const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),

      inactiveIcon: const Icon(
        Icons.favorite_border,
        size: 25,
      ),
      // title: ("Settings"),
      activeColorPrimary: MyColors.appColorUzBazar(),
      activeColorSecondary:  MyColors.appColorUzBazar(),
      inactiveColorPrimary: MyColors.appColorGrey400(),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.account_circle,
        size: 25,
      ),
      title: "cabinet".tr(),
      textStyle:const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),

      inactiveIcon: const Icon(
        Icons.account_circle_outlined,
        size: 25,
      ),
      // title: ("Settings"),
      activeColorPrimary: MyColors.appColorUzBazar(),
      activeColorSecondary:  MyColors.appColorUzBazar(),
      inactiveColorPrimary: MyColors.appColorGrey400(),
    ),
  ];
}
