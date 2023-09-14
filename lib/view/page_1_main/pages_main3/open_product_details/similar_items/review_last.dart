import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/controller_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/search_page/controller_search_page.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class ReviewItems extends ConsumerStatefulWidget {
  const ReviewItems({super.key});

  @override
  ConsumerState<ReviewItems> createState() => _ReviewItemsState();
}

class _ReviewItemsState extends ConsumerState<ReviewItems> {

  @override
  Widget build(BuildContext context) {
    final getDataSearch = ref.watch(getSimilarItem("1"));
    return Scaffold(
      body: SafeArea(child:

      ListView.builder(
        itemCount: getDataSearch.results.length,
        scrollDirection: Axis.horizontal,
        // itemBuilder: (context, index) =>
        //     Text(getDataSearch.results[index].name.toString()),
        itemBuilder: (context, index) => index <
            getDataSearch.results.length
            ? GestureDetector(
          onTap: () {
            pushNewScreen(context,
                screen: DetailsPage(
                  idProduct:
                  getDataSearch.results[index]
                      .id
                      .toString(),
                  isFavourite:
                  getDataSearch.results[index]
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
                            getDataSearch.results[index]
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
                                    ref.read(setFavourite2.notifier).updateFavorite(getDataSearch.results[index]
                                        .id
                                        .toString());
                                    ref.read(cont.notifier).updateFavorite(getDataSearch.results[index]
                                        .id
                                        .toString());
                                  },
                                  child:
                                  Icon(
                                    getDataSearch.results[index].isFavorite
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
                  SizedBox(
                    width: 120,
                    child: Text(
                        getDataSearch.results[index]
                            .name
                            .toString(),
                        maxLines: 2,
                        overflow:
                        TextOverflow.fade,
                        softWrap: true),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 30,
                    child: RatingBar.builder(
                      initialRating:
                      double.parse(
                          getDataSearch.results[
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
                            "${getDataSearch.results[index].price} so'm"),
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
                                  color: getDataSearch.results[index].slug ==
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
                                        idOrder: getDataSearch.results[index]
                                            .id
                                            .toString());
                                    ref
                                        .read(cont
                                        .notifier)
                                        .setOrders(
                                        idOrder: getDataSearch.results[index]
                                            .id
                                            .toString());
                                  },
                                  child: Icon(
                                    Icons
                                        .add_shopping_cart,
                                    color: getDataSearch.results[index]
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
      ),
    );
  }
}
