// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/mini_details/controller_mini_details.dart';
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

  @override
  initState() {
    super.initState();
    log("^^^^^");
    log(widget.brandId);
    log(widget.brandName);
    log("^^^^");
    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  getData({required String item, required WidgetRef ref}) async {
    if (indexGetData != 0) {
      ref.watch(showBrands);
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

  var box = Hive.box("online");
  @override
  void dispose() {
    ref.invalidate(showBrands);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final getBrandProduct =
        ref.watch(showBrands);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          title: Text(widget.brandName, style: const TextStyle(color: Colors.black)),
        ),
        body: SafeArea(
          child:   GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                childAspectRatio: 0.58),
            scrollDirection: Axis.vertical,
            controller: _scrollController,
            itemCount: getBrandProduct.results.length % 2 == 0
                ? getBrandProduct.results.length + 2
                : getBrandProduct.results.length + 3,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) => index < getBrandProduct.results.length
                ? GestureDetector(
              onTap: () {
                pushNewScreen(context,
                    screen: DetailsPage(
                      idProduct: getBrandProduct.results[index].id.toString(),
                      isFavourite: getBrandProduct.results[index].isFavorite,
                    ),
                    withNavBar: false);
                log(index.toString());
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(10,3,10,3),
                margin: const EdgeInsets.fromLTRB(10,3,10,3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 5),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
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
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                height: 180,
                                width:
                                MediaQuery.of(context).size.width *
                                    0.4,
                                getBrandProduct.results[index].photo.toString(),
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                    SizedBox(
                                      height: 160,
                                      width: MediaQuery.of(context)
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(setFavourite2.notifier)
                                      .updateFavorite(getBrandProduct.results[index].id
                                      .toString());

                                  ref.read(showBrands.notifier).updateFavoriteBrand(getBrandProduct.results[index].id
                                      .toString() ) ;

                                },
                                child: Container(
                                  alignment: Alignment.topRight,
                                  height: 42,
                                  width: 42,
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 10, 10, 15.0),
                                  child: Icon(
                                    getBrandProduct.results[index].isFavorite
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
                    Text(getBrandProduct.results[index].name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true),
                    const SizedBox(height: 8),
                    Visibility(
                      visible: getBrandProduct.results[index].rating == -1
                          ? true
                          : false,
                      child: SizedBox(
                        height: 30,
                        child: Row(children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow.shade600,
                          ),
                          Text(
                              getBrandProduct.results[index].rating.toString()),

                          /// Qo'shimcha qo'shish uchun
                        ]),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${getBrandProduct.results[index].price} so'm",
                                  style: const TextStyle(
                                    decoration:
                                    TextDecoration.lineThrough,
                                  )),
                              Text(
                                  "${getBrandProduct.results[index].newPrice.toStringAsFixed(2)} so'm"),
                            ],
                          ),
                          Container(
                            // padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color:
                                    getBrandProduct.results[index].slug ==
                                        "987654321"
                                        ? Colors.red
                                        : Colors.grey.shade400,
                                  )),
                              child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(setFavourite2.notifier)
                                          .setOrder(
                                          idOrder: getBrandProduct.results[index].id
                                              .toString(),
                                          count: "-1",
                                          sizeProduct: ref.read(sizeSelectProduct).toString(),
                                          colorProduct: ref.read(colorSelectProduct).toString()
                                      );


                                      ref.read(showBrands.notifier).setOrdersBrand(idOrder:getBrandProduct.results[index].id
                                          .toString() );
                                    },
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      color: Colors.transparent,
                                      child: Icon(
                                        Icons.add_shopping_cart,
                                        color:
                                        getBrandProduct.results[index].slug ==
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
            )
                : const LoadingShimmer(),
          ),
        ));
  }
}
