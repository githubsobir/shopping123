library main_page.dart;

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/network/base_url.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/new_collections.dart';
import 'package:shopping/view/page_1_main/pages_main3/search_page/search_page.dart';
import 'package:shopping/view/page_1_main/widgets_main/main_header.dart';
import 'package:shopping/widgets/colors/app_colors.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  ScrollController _scrollController = ScrollController();

  //

  @override
  initState() {
    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    super.initState();
  }

  late ModelSearch modelSearch;
  var pageCount = 1;

  _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      try {
        modelSearch = ModelSearch(page: pageCount + 1);
        log("model: ${jsonEncode(BaseClass.getLinkSearch(m: modelSearch))}");
        log("pageCount: $pageCount");
        log("count : ${ref.watch(setFavourite2).count}");
        log("next Page: ${ref.watch(setFavourite2).next}");
        log("previous Page: ${ref.watch(setFavourite2).previous}");

        await ref
            .read(setFavourite2.notifier)
            .getData(modelSearch: modelSearch);
        pageCount = pageCount + 1;
      } catch (e) {
        log(e.toString());
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("UzBazar",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () {
                  pushNewScreen(context,
                      screen: const MainSearchPage(), withNavBar: false);
                },
                child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade200)),
                    child: const Icon(Icons.search, color: Colors.white)),
              ),
            ),
          ],
          elevation: 0,
          backgroundColor: MyColors.appColorUzBazar(),
        ),
        body: SafeArea(
            child: ListView(controller: _scrollController, children: [
          const HeaderMain(),
          ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 400,
                maxHeight: double.infinity,
              ),
              child: const NewCollection()),
          ref.watch(setFavourite2).next.toString() != "999"
              ? const SizedBox(
                  height: 80,
                  child: Center(child: CupertinoActivityIndicator()),
                )
              :  SizedBox(
                  height: 60,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: IconButton(
                      onPressed: (){

                        _scrollController.animateTo(
                          0.0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 500),
                        );
                      },
                      icon:const Icon(
                      Icons.keyboard_double_arrow_up_rounded,
                      size: 28,
                      color: Colors.red,)
                    ),
                  ),
                )
        ])));
  }
}
