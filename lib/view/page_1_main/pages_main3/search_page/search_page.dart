import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/search_page/controller_search_page.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class MainSearchPage extends ConsumerStatefulWidget {
  const MainSearchPage({super.key});

  @override
  ConsumerState<MainSearchPage> createState() => _MainSearchPageState();
}

class _MainSearchPageState extends ConsumerState<MainSearchPage> {
  ScrollController _scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  int indexGetData = 1;

  getData({required String item, required WidgetRef ref}) async {
    if (indexGetData == 0) {
      ref.watch(getDataSearch(ModelSearch(search: "-1")));
    } else {
      indexGetData = 0;
    }
  }

  int pageCount = 1;

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      try {
        pageCount = pageCount + 1;
        log(pageCount.toString());
        getData(item: pageCount.toString(), ref: ref);
        // log(getData(item: pageCount.toString(), ref: ref));
      } catch (e) {
        log(e.toString());
      }
    }
  }

  int skip = 0;
  bool shouldLoadMore = true;

  @override
  Widget build(BuildContext context) {
    /// birinchi kirishda maxsus kalit so'z bilan tekshiraman
    // final listGet = ref.watch(getDataSearch(ModelSearch(search: "@@@1")));
    final getDataSearch = ref.watch(cont);
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                    child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 55,
                        child: TextField(
                          onSubmitted: (val) {
                            ref.read(cont.notifier).getListFromInternet(
                                modelSearch:
                                    ModelSearch(search: val.toString()));
                          },
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: "search".tr(),
                              // prefix: Text("search".tr(), style: TextStyle(color: Colors.grey)),

                              border: OutlineInputBorder(
                                  gapPadding: 0,
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.grey))),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                          child: getDataSearch.isNotEmpty
                              ? GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 5.0,
                                          crossAxisSpacing: 5.0,
                                          childAspectRatio: 0.55),
                                  scrollDirection: Axis.vertical,
                                  controller: _scrollController,
                                  itemCount: getDataSearch.length % 2 == 0
                                      ? getDataSearch.length + 2
                                      : getDataSearch.length + 3,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) => index <
                                          getDataSearch.length
                                      ? GestureDetector(
                                          onTap: () {
                                            pushNewScreen(context,
                                                screen: DetailsPage(
                                                  idProduct:
                                                      getDataSearch[index]
                                                          .id
                                                          .toString(),
                                                  isFavourite:
                                                      getDataSearch[index]
                                                          .isFavorite,
                                                ),
                                                withNavBar: false);
                                            log(index.toString());
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            margin: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Color.fromARGB(
                                                        232, 252, 243, 215),
                                                    blurRadius: 0.9,
                                                    offset: Offset(1, 1),
                                                    spreadRadius: 0.1)
                                              ],
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const SizedBox(height: 5),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    child: Stack(
                                                      children: [
                                                        SingleChildScrollView(
                                                          child: Image.network(
                                                            getDataSearch[index]
                                                                    .photo ??
                                                                "https://salon.fgl.su/image/icons/delivery-6.png",
                                                            height: 150,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.4,
                                                            fit: BoxFit.cover,
                                                            errorBuilder: (context,
                                                                    error,
                                                                    stackTrace) =>
                                                                SizedBox(
                                                              height: 150,
                                                              width: MediaQuery.of(
                                                                          context)
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
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  10,
                                                                  10,
                                                                  10,
                                                                  15.0),
                                                          child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topRight,
                                                              child:
                                                                  GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        ref.read(setFavourite2.notifier).updateFavorite(getDataSearch[index]
                                                                            .id
                                                                            .toString());
                                                                        ref.read(cont.notifier).updateFavorite(getDataSearch[index]
                                                                            .id
                                                                            .toString());
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        getDataSearch[index].isFavorite
                                                                            ? Icons.favorite
                                                                            : Icons.favorite_border,
                                                                        color: Colors
                                                                            .red,
                                                                      ))),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                      getDataSearch[index]
                                                          .name
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      softWrap: true),
                                                  const SizedBox(height: 8),
                                                  SizedBox(
                                                    height: 30,
                                                    child: RatingBar.builder(
                                                      initialRating:
                                                          double.parse(
                                                              getDataSearch[
                                                                      index]
                                                                  .rating
                                                                  .toString()),
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      wrapAlignment:
                                                          WrapAlignment.start,
                                                      itemPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 1.0),
                                                      itemSize: 16,
                                                      itemBuilder:
                                                          (context, _) =>
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
                                                  Text("4"),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8, right: 8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            "${getDataSearch[index].price} so'm"),
                                                        Container(
                                                            // margin: EdgeInsets.all(3),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration:
                                                                BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: getDataSearch[index].slug ==
                                                                              "987654321"
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .grey
                                                                              .shade400,
                                                                    )),
                                                            child: Center(
                                                                child:
                                                                    GestureDetector(
                                                              onTap: () {
                                                                ref
                                                                    .read(setFavourite2
                                                                        .notifier)
                                                                    .setOrder(
                                                                        idOrder: getDataSearch[index]
                                                                            .id
                                                                            .toString());
                                                                ref
                                                                    .read(cont
                                                                        .notifier)
                                                                    .setOrders(
                                                                        idOrder: getDataSearch[index]
                                                                            .id
                                                                            .toString());
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .add_shopping_cart,
                                                                color: getDataSearch[index]
                                                                            .slug ==
                                                                        "987654321"
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .grey
                                                                        .shade800,
                                                                size: 20,
                                                              ),
                                                            ))),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Center(
                                          //     child: Card(
                                          //         color: Colors.blue, child: Text(data[index].fanName)))
                                        )
                                      : const LoadingShimmer(),
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          color: Colors.white,
                                          child: Image.asset(
                                            "assets/images/empty_cart.png",
                                            height: 120,
                                          )),
                                      SizedBox(height: 20),
                                      Text("Ma'lumot topilmadi !!!"),
                                    ],
                                  ),
                                ))
                    ],
                  ),
                )))));
  }
}
