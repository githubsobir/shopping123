// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_4_favourite/model_favourite.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_4_favourite/controller_favourite.dart';

class GridCartItem extends StatefulWidget {
  // ResultProductList resultProductList;
  ResultModelNotifier resultModelNotifier;

  GridCartItem({super.key, required this.resultModelNotifier});

  @override
  State<GridCartItem> createState() => _GridCartItemState();
}

class _GridCartItemState extends State<GridCartItem> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
          margin: const EdgeInsets.fromLTRB(7, 3, 7, 3),
          child: Consumer(
            builder: (context, ref, child) =>
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                color: Colors.grey.shade50,
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
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.44,
                                widget.resultModelNotifier.product.photo
                                    .toString(),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                errorBuilder: (context, error, stackTrace) =>
                                    SizedBox(
                                      height: 160,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.4,
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
                                  // ref
                                  //     .read(getFavouriteList.notifier)
                                  //     .setFavoritesServer(
                                  //         idProduct: widget.resultModelNotifier.id
                                  //             .toString());
                                  ref
                                      .read(setFavourite2.notifier)
                                      .updateFavorite(
                                      widget.resultModelNotifier.product.id
                                          .toString());

                                  ref.read(getFavouriteList.notifier)
                                  .setFavouriteList(resultModelNotifier: widget.resultModelNotifier);
                                  // setState(() {});
                                },
                                child: Container(
                                  alignment: Alignment.topRight,
                                  height: 42,
                                  width: 42,
                                  color: Colors.transparent,
                                  padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 15.0),
                                  child: Icon(
                                    widget.resultModelNotifier.isActive
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
                    Text(widget.resultModelNotifier.product.name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true),
                    const SizedBox(height: 8),
                    Visibility(
                      visible:
                      widget.resultModelNotifier.product == -1 ? true : false,
                      child: SizedBox(
                        height: 30,
                        child: Row(children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow.shade600,
                          ),
                          Text(widget.resultModelNotifier.product.name
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
                              Text("${widget.resultModelNotifier.product
                                  .price} \$",
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 12)),
                              Text("${widget.resultModelNotifier.product
                                  .price}",
                                  // "${getData.results[index].newPrice.toStringAsFixed(2)} so'm",
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                          // Container(
                          //     // padding: const EdgeInsets.all(5),
                          //     decoration: BoxDecoration(
                          //         shape: BoxShape.circle,
                          //         border: Border.all(
                          //           color: widget.resultModelNotifier.product ==
                          //                   "987654321"
                          //               ? Colors.red
                          //               : Colors.grey.shade400,
                          //         )),
                          //     child: Center(
                          //         child: GestureDetector(
                          //       onTap: () {
                          //         if (widget.resultModelNotifier.product ==
                          //             "987654321") {
                          //           ref.read(setFavourite2.notifier).setOrder(
                          //               idOrder:widget.resultModelNotifier
                          //                   .id
                          //                   .toString(),
                          //               count: "0",
                          //               colorProduct: "",
                          //               sizeProduct: "");
                          //         } else {
                          //           ref.read(boolHideNavBar.notifier).state = true;
                          //
                          //           MyWidgets.bottomSheetDetails(
                          //               idProduct: widget.resultModelNotifier
                          //                   .id
                          //                   .toString(),
                          //               isFavourite: widget.resultModelNotifier
                          //                   .isActive,
                          //               context: context,
                          //               ref: ref);
                          //         }
                          //       },
                          //       child: Container(
                          //         width: 40,
                          //         height: 45,
                          //         color: Colors.transparent,
                          //         child: Icon(
                          //           Icons.add_shopping_cart,
                          //           color: widget.resultModelNotifier.isActive ==
                          //                   "987654321"
                          //               ? Colors.red
                          //               : Colors.grey.shade800,
                          //           size: 20,
                          //         ),
                          //       ),
                          //     ))),
                        ],
                      ),
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
