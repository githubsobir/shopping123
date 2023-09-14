// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/search_page/controller_search_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/show_brands/controller_show_brands.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class ShowBrands extends ConsumerStatefulWidget {
  String brandId;
  String brandName;

  ShowBrands({super.key, required this.brandId, required this.brandName});

  @override
  ConsumerState<ShowBrands> createState() => _ShowBrandsState();
}

class _ShowBrandsState extends ConsumerState<ShowBrands> {
  ScrollController _scrollController = ScrollController();
  int indexGetData = 1;
  late ModelSearch modelSearch;

  @override
  initState() {
    super.initState();
    modelSearch = ModelSearch(brand: widget.brandId);
    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  getData({required String item, required WidgetRef ref}) async {
    if (indexGetData == 0) {
      ref.watch(showBrands(ModelSearch(search: item)));
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

  @override
  Widget build(BuildContext context) {
    log(widget.brandId);
    final getBrandProduct =
        // ref.watch(showBrands);
        ref.watch(showBrands(modelSearch));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          title: Text(widget.brandName, style: TextStyle(color: Colors.black)),
        ),
        body: SafeArea(
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 0.55),
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            itemCount: getBrandProduct.results.length % 2 == 0
                ? getBrandProduct.results.length + 2
                : getBrandProduct.results.length + 3,
            physics:
            const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) => index <
                getBrandProduct.results.length
                ? GestureDetector(
              onTap: () {
                pushNewScreen(context,
                    screen: DetailsPage(
                      idProduct:
                      getBrandProduct.results[index]
                          .id
                          .toString(),
                      isFavourite:
                      getBrandProduct.results[index]
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
                                getBrandProduct.results[index]
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

                                            ref.read(showBrands(ModelSearch(brand: "-1")).notifier).updateFavoriteBrand(getBrandProduct.results[index]
                                                .id
                                                .toString());

                                        // ref.read(setFavourite2.notifier).updateFavorite(getBrandProduct.results[index]
                                        //     .id
                                        //     .toString());
                                        //
                                        //
                                        // ref.read(cont.notifier).updateFavorite(getBrandProduct.results[index]
                                        //     .id
                                        //     .toString());
                                      },
                                      child:
                                      Icon(
                                        getBrandProduct.results[index].isFavorite
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
                          getBrandProduct.results[index]
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
                              getBrandProduct.results[
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
                                "${getBrandProduct.results[index].price} so'm"),
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
                                      color: getBrandProduct.results[index].slug ==
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
                                            idOrder: getBrandProduct.results[index]
                                                .id
                                                .toString());
                                        ref
                                            .read(cont
                                            .notifier)
                                            .setOrders(
                                            idOrder: getBrandProduct.results[index]
                                                .id
                                                .toString());
                                      },
                                      child: Icon(
                                        Icons
                                            .add_shopping_cart,
                                        color: getBrandProduct.results[index]
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
        ));
  }
}
