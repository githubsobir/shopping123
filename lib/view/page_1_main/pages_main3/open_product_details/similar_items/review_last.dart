// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/controller_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/mini_details/controller_mini_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/search_page/controller_search_page.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class ReviewItems extends ConsumerStatefulWidget {
  ReviewItems({super.key, required this.type});

  String type;

  @override
  ConsumerState<ReviewItems> createState() => _ReviewItemsState();
}

class _ReviewItemsState extends ConsumerState<ReviewItems> {
  var box = Hive.box("online");

  // box.put("listLastView", jsonEncode(listModelDetails).toString());
  @override
  Widget build(BuildContext context) {
    final getDataSearch = ref.watch(getLastViews);
    return Scaffold(
      body: SafeArea(
          child: ListView.builder(
        itemCount: getDataSearch.length,
        scrollDirection: Axis.horizontal,
        // itemBuilder: (context, index) =>
        //     Text(getDataSearch.results[index].name.toString()),
        itemBuilder: (context, index) => index < getDataSearch.length
            ? GestureDetector(
                onTap: () {
                  MyWidgets.getDefaultStateDetailPage(ref: ref);
                  pushNewScreen(context,
                      screen: DetailsPage(
                        boolShowStore: true,
                        idProduct: getDataSearch[index].id.toString(),
                        idProduct2: "",
                        isFavourite: false,
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
                          color: Color.fromARGB(232, 252, 243, 215),
                          blurRadius: 0.9,
                          offset: Offset(1, 1),
                          spreadRadius: 0.1)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SingleChildScrollView(
                    physics:const NeverScrollableScrollPhysics(),
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
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: 200,
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          getDataSearch[index].variables.length,
                                      itemBuilder: (context, index2) =>
                                          Image.network(
                                        getDataSearch[index]
                                                .variables[index2]
                                                .media
                                                .isNotEmpty
                                            ? getDataSearch[index]
                                                    .variables[0]
                                                    .media[index2]
                                                    .file ??
                                                "https://salon.fgl.su/image/icons/delivery-6.png"
                                            : "https://salon.fgl.su/image/icons/delivery-6.png",
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
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
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 15.0),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(setFavourite2.notifier)
                                              .updateFavorite(
                                                  getDataSearch[index]
                                                      .id
                                                      .toString());
                                          ref
                                              .read(cont.notifier)
                                              .updateFavorite(
                                                  getDataSearch[index]
                                                      .id
                                                      .toString());
                                        },
                                        child: const Icon(
                                          false
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.red,
                                        ))),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 120,
                          child: Text(getDataSearch[index].name.toString(),
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
                                Text(getDataSearch[index].rating ?? "-",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14)),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${getDataSearch[index].price} \$"),
                                Container(
                                    // margin: EdgeInsets.all(3),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: false
                                              ? Colors.red
                                              : Colors.grey.shade400,
                                        )),
                                    child: Center(
                                        child: GestureDetector(
                                      onTap: () {
                                        ref
                                            .read(setFavourite2.notifier)
                                            .setOrder(
                                                idOrder: getDataSearch[index]
                                                    .id
                                                    .toString(),
                                                count: "-1",
                                                sizeProduct: ref
                                                    .read(sizeSelectProduct)
                                                    .toString(),
                                                colorProduct: ref
                                                    .read(colorSelectProduct)
                                                    .toString());
                                        ref.read(cont.notifier).setOrders(
                                            idOrder: getDataSearch[index]
                                                .id
                                                .toString());
                                      },
                                      child: Icon(
                                        Icons.add_shopping_cart,
                                        color: false
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
                // Center(
                //     child: Card(
                //         color: Colors.blue, child: Text(data[index].fanName)))
              )
            : const LoadingShimmer(),
      )),
    );
  }
}
