// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/controller_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/mini_details/controller_mini_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/search_page/controller_search_page.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class SimilarItems extends ConsumerStatefulWidget {
  String idDetail;

  SimilarItems({super.key, required this.idDetail});

  @override
  ConsumerState<SimilarItems> createState() => _SimilarItemsState();
}

class _SimilarItemsState extends ConsumerState<SimilarItems> {
  @override
  Widget build(BuildContext context) {
    final getDataSearch = ref.watch(getSimilarItem(widget.idDetail));
    return SafeArea(
        child: ListView.builder(
      itemCount: getDataSearch.results.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => index < getDataSearch.results.length
          ? GestureDetector(
              onTap: () {
                ref.read(boolIsFavourite.notifier).state =
                    getDataSearch.results[index].isFavorite;
                pushNewScreen(context,
                    screen: DetailsPage(
                      boolShowStore: true,
                      idProduct: getDataSearch.results[index].id.toString(),
                      idProduct2: "",
                      isFavourite: getDataSearch.results[index].isFavorite,
                    ),
                    withNavBar: false);
                log(index.toString());
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(1, 1, 4, 0),
                margin: const EdgeInsets.fromLTRB(3, 5, 3, 0),
                decoration: BoxDecoration(
                  // border: Border.all(color: Colors.grey.shade100),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(232, 252, 243, 215),
                        blurRadius: 0.9,
                        offset: Offset(1, 1),
                        spreadRadius: 0.1)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl: 
                                  getDataSearch.results[index].photo ??
                                      "https://salon.fgl.su/image/icons/delivery-6.png",
                                  height: 200,
                                  alignment: Alignment.topCenter,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, error, stackTrace) =>
                                      SizedBox(
                                    height: 150,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Image.asset(
                                        "assets/images/shopping1.png"),
                                  ),
                                  // height: 100,
                                  // width: 150,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 5, 5, 5.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(setFavourite2.notifier)
                                            .updateFavorite(getDataSearch
                                                .results[index].id
                                                .toString());
                                        ref.read(cont.notifier).updateFavorite(
                                            getDataSearch.results[index].id
                                                .toString());


                                        ref
                                            .read(
                                                getSimilarItem(widget.idDetail)
                                                    .notifier)
                                            .updateFavourite(index);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: Icon(
                                          getDataSearch.results[index].isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color:
                                          getDataSearch.results[index].isFavorite?Colors.red:
                                          Colors.grey,
                                        ),
                                      ))),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 120,
                        child: Text(
                            getDataSearch.results[index].name.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            softWrap: true),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 10),
                              Text(getDataSearch.results[index].rating.toString(),
                                  style: const TextStyle(

                                      fontSize: 14)),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${getDataSearch.results[index].price} \$"),
                              Container(
                                  // margin: EdgeInsets.all(3),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:
                                            getDataSearch.results[index].isCart
                                                ? Colors.red
                                                : Colors.grey.shade400,
                                      )),
                                  child: Center(
                                      child: GestureDetector(
                                    onTap: () {
                                      ref.read(setFavourite2.notifier).setOrder(
                                          idOrder: getDataSearch
                                              .results[index].id
                                              .toString(),
                                          count: "-1",
                                          sizeProduct: ref
                                              .read(sizeSelectProduct)
                                              .toString(),
                                          colorProduct: ref
                                              .read(colorSelectProduct)
                                              .toString());
                                      ref.read(cont.notifier).setOrders(
                                          idOrder: getDataSearch
                                              .results[index].id
                                              .toString());
                                    },
                                    child: Icon(
                                      Icons.add_shopping_cart,
                                      color: getDataSearch.results[index].isCart
                                          ? Colors.red
                                          : Colors.grey.shade800,
                                      size: 20,
                                    ),
                                  ))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const LoadingShimmer(),
    ));
  }
}
