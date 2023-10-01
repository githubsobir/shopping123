library main_page.dart;

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/view/page_1_main/pages_main3/best_seller/best_sellers.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/new_collections.dart';
import 'package:shopping/view/page_1_main/pages_main3/sale/sales.dart';
import 'package:shopping/view/page_1_main/pages_main3/search_page/search_page.dart';
import 'package:shopping/view/page_1_main/widgets_main/main_header.dart';
import 'package:shopping/widgets/colors/app_colors.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("UzBazar", style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () {
                  pushNewScreen(context,
                      screen: MainSearchPage(), withNavBar: false);
                },
                child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade200)),
                    child: Icon(Icons.search, color: Colors.white)),
              ),
            ),

            /// title o'riniga qo'yish mumkin
            // Container(
            //   height: 45,
            //   decoration: BoxDecoration(
            //       color: Colors.white, borderRadius: BorderRadius.circular(8)),
            //   child: Padding(
            //       padding: EdgeInsets.only(left: 10),
            //       child: Row(
            //         children: [
            //           Icon(Icons.search, color: Colors.grey),
            //           SizedBox(width: 10),
            //           Text(
            //             "search".tr(),
            //             style: TextStyle(color: Colors.grey),
            //           )
            //         ],
            //       ))),
          ],
          elevation: 0,
          backgroundColor: MyColors.appColorUzBazar(),
          // leading:
          //   Container(
          //     height: 45,
          //       color: Colors.white,
          //       child: TextFormField()),
        ),
        body: SafeArea(
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [const HeaderMain()];
            },
            // body: mainBody(context: context, ref: ref)),
            body: ContainedTabBarView(
              tabBarProperties: TabBarProperties(
                // padding: const EdgeInsets.symmetric(horizontal: 1),
                margin: const EdgeInsets.only(bottom: 5, top: 5, right: 1, left: 1),
                isScrollable: false,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xff121212)),
                ),
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 6),
                labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                labelColor: Colors.black,
                indicatorColor: Colors.red,

                height: 35,
              ),
              tabs: [
                Text('bestSeller'.tr()),
                Text('newArrivals'.tr()),
                Text('sale'.tr()),
              ],
              views: const [NewCollection(), BestSellers(), Sales()],
              // views: const [NewCollection(), NewCollection(), NewCollection()],
            ),
          ),
        ));
  }
}
