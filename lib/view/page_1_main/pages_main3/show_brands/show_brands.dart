// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/controller_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/show_brands/controller_show_brands.dart';
import 'package:shopping/view/page_4_favourite/controller_favourite.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
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
  Widget build(BuildContext context) {
    final getBrandProduct = ref.watch(showBrands);
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          title: Text(widget.brandName,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: Form(
          onPopInvoked: (val){
            // ref.invalidate(showBrands);
          },
          child: SafeArea(
            child:
            getBrandProduct.results.isNotEmpty?
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              // physics: ScrollPhysics(),
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: 0.56),
              itemCount: getBrandProduct.results.length,
              itemBuilder: (context, index) => index <
                      getBrandProduct.results.length
                  ? GestureDetector(
                      onTap: () {
                        try {
                          log("3333");
                        } catch (e) {
                          log(e.toString());
                        }
                        ref.read(boolIsFavourite.notifier).state =
                            getBrandProduct.results[index].isFavorite;
                        MyWidgets.getDefaultStateDetailPage(ref: ref);
                        pushNewScreen(context,
                            screen: DetailsPage(
                              idProduct:
                                  getBrandProduct.results[index].id.toString(),
                              idProduct2: "",
                              boolShowStore: true,
                              isFavourite:
                                  getBrandProduct.results[index].isFavorite,
                            ),
                            withNavBar: false);
                        log(index.toString());
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                        margin: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
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
                                    physics: const NeverScrollableScrollPhysics(),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        height: 180,
                                        width: MediaQuery.of(context).size.width *
                                            0.44,
                                        alignment: Alignment.topCenter,
                                        getBrandProduct.results[index].photo
                                            .toString(),
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                SizedBox(
                                          height: 160,
                                          width:
                                              MediaQuery.of(context).size.width *
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


                                          ref.read(showBrands.notifier).updateFavoriteBrand(getBrandProduct
                                              .results[index].id.toString());

                                          ref
                                              .read(setFavourite2.notifier)
                                              .updateFavorite(getBrandProduct
                                                  .results[index].id
                                                  .toString());




                                          ref
                                              .read(getFavouriteList.notifier)
                                              .setFavouriteList(
                                              resultModelNotifier:
                                              ResultModelNotifier(
                                                  isActive: getBrandProduct
                                                      .results[index]
                                                      .isFavorite,
                                                  id: getBrandProduct
                                                      .results[index].id,
                                                  product: Product(
                                                      id: getBrandProduct
                                                          .results[index]
                                                          .id,
                                                      name: getBrandProduct
                                                          .results[index]
                                                          .name,
                                                      price: getBrandProduct
                                                          .results[index]
                                                          .price,
                                                      photo: getBrandProduct
                                                          .results[index]
                                                          .photo)));

                                          // setState(() {});
                                        },
                                        child: Container(
                                          alignment: Alignment.topRight,
                                          height: 42,
                                          width: 42,
                                          color: Colors.transparent,
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 15.0),
                                          child: Icon(
                                            getBrandProduct
                                                    .results[index].isFavorite
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
                                  Text(getBrandProduct.results[index].rating
                                      .toString()),

                                  /// Qo'shimcha qo'shish uchun
                                ]),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "${getBrandProduct.results[index].price} \$",
                                          style: const TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 12)),
                                      Text("$index",
                                          // "${getData.results[index].newPrice.toStringAsFixed(2)} so'm",
                                          style: const TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                  Container(
                                      // padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: getBrandProduct
                                                    .results[index].isCart
                                                ? Colors.red
                                                : Colors.grey.shade400,
                                          )),
                                      child: Center(
                                          child: GestureDetector(
                                        onTap: () {
                                          if (getBrandProduct
                                              .results[index].isCart) {
                                            ref
                                                .read(setFavourite2.notifier)
                                                .setOrder(
                                                    idOrder: getBrandProduct
                                                        .results[index].id
                                                        .toString(),
                                                    count: "0",
                                                    colorProduct: "",
                                                    sizeProduct: "");
                                          } else {
                                            MyWidgets.bottomSheetDetails(
                                                idProduct: getBrandProduct
                                                    .results[index].id
                                                    .toString(),
                                                isFavourite: getBrandProduct
                                                    .results[index].isFavorite,
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
                                            color: getBrandProduct
                                                    .results[index].isCart
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
            )
            :Center(child: Text("Maxsulot topilmadi"))
            ,
          ),
        ));
  }
}
