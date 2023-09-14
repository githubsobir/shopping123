// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/search_page/controller_search_page.dart';
import 'package:shopping/view/page_4_favourite/favourite_empty.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class FavouritePage extends ConsumerStatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends ConsumerState<FavouritePage> {
  ScrollController _scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
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
  List<ResultProductList> getList({required List<ResultProductList> l}){

    List<ResultProductList> listReturn = [];
    for(int i = 0; i < l.length; i++){
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
          child: Padding(
              padding: const EdgeInsets.all(8),
              child:
              getList(l: list.results).isNotEmpty?
              GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5.0,
                              crossAxisSpacing: 5.0,
                              childAspectRatio: 0.55),
                      scrollDirection: Axis.vertical,
                      controller: _scrollController,
                      itemCount: getList(l: list.results).length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                        getList(l: list.results).isNotEmpty
                          ?
                      GestureDetector(
                              onTap: () {
                                pushNewScreen(context,
                                    screen: DetailsPage(
                                      idProduct: index.toString(),
                                      isFavourite:getList(l: list.results)[index].isFavorite,
                                    ));
                                // log(index.toString());
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color:
                                            Color.fromARGB(232, 252, 243, 215),
                                        blurRadius: 0.9,
                                        offset: Offset(1, 1),
                                        spreadRadius: 0.1)
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 5),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Stack(
                                          children: [
                                            SingleChildScrollView(
                                              child: Image.network(
                                                height: 150,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                getList(l: list.results)[index].photo.toString(),
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    SizedBox(
                                                  height: 150,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: Image.asset(
                                                      "assets/images/shopping1.png"),
                                                ),
                                                // height: 100,
                                                // width: 150,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 10, 15.0),
                                              child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        ref
                                                            .read(setFavourite2
                                                                .notifier)
                                                            .updateFavorite(
                                                            getList(l: list.results)[index]
                                                                    .id
                                                                    .toString());
                                                      },
                                                      child: Icon(
                                                        getList(l: list.results)[index].isFavorite
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border,
                                                        color: Colors.red,
                                                      ))),
                                            )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(getList(l: list.results)[index].name.toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.fade,
                                          softWrap: true),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        height: 30,
                                        child: RatingBar.builder(
                                          initialRating: double.parse(
                                              getList(l: list.results)[index].rating.toString()),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          wrapAlignment: WrapAlignment.start,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 1.0),
                                          itemSize: 16,
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 10,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text("4"),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("${getList(l: list.results)[index].price} so'm"),
                                            GestureDetector(
                                              onTap: () {
                                                ref
                                                    .read(
                                                        setFavourite2.notifier)
                                                    .setOrder(
                                                        idOrder: getList(l: list.results)[index]
                                                            .id
                                                            .toString());
                                              },
                                              child: Container(
                                                  // margin: EdgeInsets.all(3),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: getList(l: list.results)[index]
                                                                      .slug ==
                                                                  "987654321"
                                                              ? Colors.red
                                                              : Colors.grey
                                                                  .shade800)),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.add_shopping_cart,
                                                    color: getList(l: list.results)[index].slug ==
                                                            "987654321"
                                                        ? Colors.red
                                                        : Colors.grey.shade800,
                                                    size: 20,
                                                  ))),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                       : const LoadingShimmer(),
                  // : favouriteEmpty(context: context)
              )
          : favouriteEmpty(context: context)
          )),
    );
  }
}
