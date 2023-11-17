// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/view/page_0_root/controller_root_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/controller_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/mini_details/controller_mini_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/open_store_products/controller_open_all_product.dart';
import 'package:shopping/view/page_1_main/pages_main3/search_page/controller_search_page.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class OpenStoreAllProduct extends ConsumerStatefulWidget {
  String categoryId;
  String parentId;
  String categoryName;
  String organization;

  OpenStoreAllProduct(
      {super.key,
      required this.categoryId,
      required this.parentId,
      required this.categoryName,
      required this.organization,

      });

  @override
  ConsumerState<OpenStoreAllProduct> createState() =>
      _OpenStoreAllProductState();
}

class _OpenStoreAllProductState extends ConsumerState<OpenStoreAllProduct> {
  @override
  Widget build(BuildContext context) {
    final getData = ref.watch(getAllProductStore(widget.organization));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName, style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
          child:   GridView.builder(
            shrinkWrap: true,
            // physics: ScrollPhysics(),

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 0.56),
            itemCount: getData.results.length,
            itemBuilder: (context, index) => index < getData.results.length
                ? GestureDetector(
              onTap: () {
                try {
                  log("3333");
                } catch (e) {
                  log(e.toString());
                }
                ref.read(boolIsFavourite.notifier).state =
                    getData.results[index].isFavorite;
                // MyWidgets.getDefaultStateDetailPage(ref: ref);
                pushNewScreen(context,
                    screen: DetailsPage(
                      boolShowStore: false,
                      idProduct: getData.results[index].id.toString(),
                      idProduct2: "",
                      isFavourite: getData.results[index].isFavorite,
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
                        // boxShadow: [
                        //   BoxShadow(
                        //       blurRadius: 1,
                        //       color: Colors.grey.shade100,
                        //       offset: const Offset(1, 0),
                        //       spreadRadius: 10)
                        // ],
                      ),
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            physics:
                            const NeverScrollableScrollPhysics(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                height: 180,
                                alignment: Alignment.topCenter,
                                width:
                                MediaQuery.of(context).size.width *
                                    0.44,
                                getData.results[index].photo.toString(),
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
                                      .updateFavorite(getData
                                      .results[index].id
                                      .toString());
                                  // ref
                                  //     .read(getFavouriteList.notifier)
                                  //     .setFavouriteList(
                                  //     resultModelNotifier:
                                  //     ResultModelNotifier(
                                  //         isActive: getData
                                  //             .results[index]
                                  //             .isFavorite,
                                  //         id: getData
                                  //             .results[index]
                                  //             .id,
                                  //         product: Product(
                                  //             id: getData.results[index].id,
                                  //             name: getData.results[index].name,
                                  //             price: getData.results[index].price,
                                  //             photo: getData.results[index].photo)));
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
                                    getData.results[index].isFavorite
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
                    Text(getData.results[index].name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true),
                    const SizedBox(height: 8),
                    Visibility(
                      visible: getData.results[index].rating == -1
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
                              getData.results[index].rating.toString()),

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
                              Text("${getData.results[index].price} \$",
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
                                    color: getData.results[index].isCart
                                        ? Colors.red
                                        : Colors.grey.shade400,
                                  )),
                              child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (getData.results[index].isCart) {
                                        ref
                                            .read(setFavourite2.notifier)
                                            .setOrder(
                                            idOrder: getData
                                                .results[index].id
                                                .toString(),
                                            count: "0",
                                            colorProduct: "",
                                            sizeProduct: "");
                                      } else {
                                        ref
                                            .read(boolHideNavBar.notifier)
                                            .state = true;
                                        MyWidgets.bottomSheetDetails(
                                            idProduct: getData
                                                .results[index].id
                                                .toString(),
                                            isFavourite: getData
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
                                        color: getData.results[index].isCart
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
          ),),
    );
  }
}
