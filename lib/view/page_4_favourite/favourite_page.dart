// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/view/page_0_root/controller_root_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/controller_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/mini_details/controller_mini_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/mini_details/mini_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/search_page/controller_search_page.dart';
import 'package:shopping/view/page_4_favourite/favourite_empty.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class FavouritePage extends ConsumerStatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends ConsumerState<FavouritePage>
    with SingleTickerProviderStateMixin<FavouritePage> {
  ScrollController _scrollController = ScrollController();
  late AnimationController _slideAnimationController;


  late Animation<double> _heightFactorAnimation;

  @override
  initState() {
    _slideAnimationController = AnimationController(
      vsync: this,
      //whatever duration you want
      duration: const Duration(milliseconds: 800),
    );
    _heightFactorAnimation = CurvedAnimation(
        parent: _slideAnimationController.drive(
          //a Tween from 1.0 to 0.0 is what makes the slide effect by shrinking
          // the container using the [Align.heightFactor] parameter
          Tween<double>(
            begin: 1.0,
            end: 0.0,
          ),
        ),
        curve: Curves.ease);
    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    super.initState();
  }

  int pageCount = 1;

  _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      try {
        pageCount = pageCount + 1;
        log(pageCount.toString());
        // getData(item: pageCount.toString(), ref: ref);
        // log(getData(item: pageCount.toString(), ref: ref));
      } catch (e) {
        log(e.toString());
      }
    }
  }

  int skip = 0;
  bool shouldLoadMore = true;

  List<ResultProductList> getList({required List<ResultProductList> l}) {
    List<ResultProductList> listReturn = [];
    for (int i = 0; i < l.length; i++) {
      if (l[i].isFavorite.toString() == "true") {
        listReturn.add(l[i]);
      }
    }
    log(listReturn.length.toString());

    return listReturn;
  }


  @override
  Widget build(BuildContext context) {
    final list = ref.watch(setFavourite2);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("favourite".tr(),
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: getList(l: list.results).isNotEmpty ?
          GridView.builder(
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            // physics: ScrollPhysics(),
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 0.56),
            itemCount: getList(l: list.results).length,
            itemBuilder: (context, index) =>
            index <
                getList(l: list.results).length
                ? GestureDetector(
              onTap: () {
                ref
                    .read(boolIsFavourite.notifier)
                    .state = getList(l: list.results)[index].isFavorite;
                MyWidgets.getDefaultStateDetailPage(ref: ref);
                pushNewScreen(context,
                    screen: DetailsPage(
                      idProduct:
                      getList(l: list.results)[index].id.toString(),
                      isFavourite:
                      getList(l: list.results)[index].isFavorite,
                      idProduct2: "",
                    ),
                    withNavBar: false);
                log(index.toString());
              },
              child:
              AnimatedBuilder(animation: _slideAnimationController,
                builder: (context, child) =>
                    ClipRect(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        heightFactor: _heightFactorAnimation.value,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                          margin: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Container(
                                width:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 1,
                                          color: Colors.grey.shade100,
                                          offset: const Offset(1, 0),
                                          spreadRadius: 10)
                                    ]),
                                child: Stack(
                                  children: [
                                    SingleChildScrollView(
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        child: Image.network(
                                          height: 180,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width *
                                              0.44,
                                          getList(l: list.results)[index].photo
                                              .toString(),
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                              SizedBox(
                                                height: 160,
                                                width: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width *
                                                    0.4,
                                                child: Image.asset(
                                                    height: 160,
                                                    "assets/images/shopping1.png"),
                                              ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _slideAnimationController.forward();
                                            ref
                                                .read(setFavourite2.notifier)
                                                .updateFavorite(
                                                getList(l: list.results)[index]
                                                    .id
                                                    .toString());

                                            // setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.topRight,
                                            height: 42,
                                            width: 42,
                                            color: Colors.transparent,
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                10, 10, 10, 15.0),
                                            child: Icon(
                                              getList(l: list.results)[index]
                                                  .isFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(getList(l: list.results)[index].name
                                  .toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true),
                              const SizedBox(height: 8),
                              Visibility(
                                visible: getList(l: list.results)[index]
                                    .rating == -1
                                    ? true
                                    : false,
                                child: SizedBox(
                                  height: 30,
                                  child: Row(children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow.shade600,
                                    ),
                                    Text(getList(l: list.results)[index].rating
                                        .toString()),

                                    /// Qo'shimcha qo'shish uchun
                                  ]),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 8, right: 8),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${getList(l: list.results)[index]
                                                .price} \$",
                                            style: const TextStyle(
                                                decoration: TextDecoration
                                                    .lineThrough,
                                                fontSize: 12)),
                                        Text("$index",
                                            // "${getData.results[index].newPrice.toStringAsFixed(2)} so'm",
                                            style: const TextStyle(
                                                fontSize: 12)),
                                      ],
                                    ),
                                    Container(
                                      // padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: getList(
                                                  l: list.results)[index]
                                                  .slug ==
                                                  "987654321"
                                                  ? Colors.red
                                                  : Colors.grey.shade400,
                                            )),
                                        child: Center(
                                            child: GestureDetector(
                                              onTap: () {


                                            if(getList(
                                            l: list.results)[index]
                                                .slug ==
                                            "987654321"){
                                              ref
                                                  .read(
                                                  setFavourite2.notifier)
                                                  .setOrder(
                                                  idOrder: getList(
                                                      l: list
                                                          .results)[
                                                  index]
                                                      .id
                                                      .toString(),
                                                  count: "0",
                                                  colorProduct:
                                                  "",
                                                  sizeProduct:
                                                  "");
                                            }else {
                                                      ref
                                                          .read(boolHideNavBar
                                                              .notifier)
                                                          .state = true;

                                                      MyWidgets.bottomSheetDetails(
                                                          idProduct: getList(
                                                                      l: list
                                                                          .results)[
                                                                  index]
                                                              .id
                                                              .toString(),
                                                          isFavourite: getList(
                                                                      l: list
                                                                          .results)[
                                                                  index]
                                                              .isFavorite,
                                                          context: context,
                                                          ref: ref);
                                                    }
                                                  },
                                              child: Container(
                                                width: 40,
                                                height: 45,
                                                color: Colors.transparent,
                                                child: Icon(
                                                  Icons.add_shopping_cart,
                                                  color: getList(
                                                      l: list.results)[index]
                                                      .slug ==
                                                      "987654321"
                                                      ? Colors.red
                                                      : Colors.grey.shade800,
                                                  size: 20,
                                                ),
                                              ),
                                            ))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              ),

            )
                : const LoadingShimmer(),
          )
              : favouriteEmpty(context: context)),
    );
  }
}
