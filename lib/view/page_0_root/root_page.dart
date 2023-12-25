// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/data/model/model_0_root/model_ip_address.dart';
import 'package:shopping/view/page_0_root/controller_root_page.dart';
import 'package:shopping/view/page_1_main/main_page.dart';
import 'package:shopping/view/page_2_category/category_page.dart';
import 'package:shopping/view/page_3_basket/basket_page.dart';
import 'package:shopping/view/page_3_basket/controller_basket.dart';
import 'package:shopping/view/page_4_favourite/controller_favourite.dart';
import 'package:shopping/view/page_4_favourite/favourite_page.dart';
import 'package:shopping/view/page_5_account/account_page.dart';
import 'package:shopping/widgets/colors/app_colors.dart';

class RootPage extends ConsumerStatefulWidget {
  int homeIdMainpage;

  RootPage({Key? key, required this.homeIdMainpage}) : super(key: key);

  @override
  ConsumerState<RootPage> createState() => _RootPageState();
}

class _RootPageState extends ConsumerState<RootPage> {


  List<Widget> myPages() => [
        const MainPage(),
        const CategoryPage(),
        const BasketPage(),
        const FavouritePage(),
        const AccountPage()
      ];
  int index = 0;
  late PersistentTabController controller;

  var box = Hive.box("online");

  Future getFirstAction() async {
    try {
      await Future.delayed(Duration.zero);
      try {
        /// Initialize Ip Address
        var ipAddress = IpAddress(type: RequestType.json);
        dynamic data = await ipAddress.getIpAddress();
        ModelIpAddress ipNumber =
            ModelIpAddress.fromJson(jsonDecode(jsonEncode(data)));
        box.delete("ipAddressPhone");
        box.put("ipAddressPhone", ipNumber.ip.toString());
        log(box.get("ipAddressPhone"));
      } on IpAddressException catch (exception) {
        /// Handle the exception.
        log(exception.message.toString());
      }
    } catch (e) {
      throw Exception("Error update");
    }
  }

  @override
  initState() {
    super.initState();
    controller =
        PersistentTabController(initialIndex: widget.homeIdMainpage);
    getFirstAction();

  }

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
      // stateManagement: true,
      hideNavigationBar: ref.watch(boolHideNavBar),
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        colorBehindNavBar: MyColors.appColorBlue1(),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      navBarStyle: NavBarStyle.style3,
       onItemSelected: (val){
         if(val == 2)
         {

           ref.read(getOrder.notifier).getBasketList();}
         else if (val == 3) {
           ref.read(  getFavouriteList.notifier).getFavouriteListFirst();

         }

       },
      selectedTabScreenContext: (p0) {

      },
      screenTransitionAnimation:
          const ScreenTransitionAnimation(curve: Curves.bounceIn),
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
      textStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      inactiveIcon: const Icon(
        Icons.home_outlined,
        size: 25,
      ),
      // title: ("Home"),
      activeColorPrimary: MyColors.appColorUzBazar(),
      activeColorSecondary: MyColors.appColorUzBazar(),
      inactiveColorPrimary: MyColors.appColorGrey400(),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.manage_search_rounded,
        size: 25,
      ),
      title: "category".tr(),
      textStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      inactiveIcon: const Icon(
        Icons.manage_search_rounded,
        size: 25,
      ),
      activeColorPrimary: MyColors.appColorUzBazar(),
      activeColorSecondary: MyColors.appColorUzBazar(),
      inactiveColorPrimary: MyColors.appColorGrey400(),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        CupertinoIcons.cart_fill,
        size: 25,
      ),
      title: "basket".tr(),
      textStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      inactiveIcon: const Icon(
        CupertinoIcons.shopping_cart,
        size: 25,
      ),
      activeColorPrimary: MyColors.appColorUzBazar(),
      activeColorSecondary: MyColors.appColorUzBazar(),
      inactiveColorPrimary: MyColors.appColorGrey400(),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.favorite,
        size: 25,
      ),
      title: "favourite".tr(),
      textStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),

      inactiveIcon: const Icon(
        Icons.favorite_border,
        size: 25,
      ),
      // title: ("Settings"),
      activeColorPrimary: MyColors.appColorUzBazar(),
      activeColorSecondary: MyColors.appColorUzBazar(),
      inactiveColorPrimary: MyColors.appColorGrey400(),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        Icons.account_circle,
        size: 25,
      ),
      title: "cabinet".tr(),
      textStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),

      inactiveIcon: const Icon(
        CupertinoIcons.person,
        size: 25,
      ),
      // title: ("Settings"),
      activeColorPrimary: MyColors.appColorUzBazar(),
      activeColorSecondary: MyColors.appColorUzBazar(),
      inactiveColorPrimary: MyColors.appColorGrey400(),
    ),
  ];
}
