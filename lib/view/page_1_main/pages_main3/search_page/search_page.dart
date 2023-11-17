import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/controller_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/search_page/controller_search_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/search_page/filter/filter_controller.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
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
      // ref.watch(getDataSearch(ModelSearch(search: "-1")));
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

@override
  void dispose() {

    ref.invalidate(cont);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    /// birinchi kirishda maxsus kalit so'z bilan tekshiraman
    // final listGet = ref.watch(getDataSearch(ModelSearch(search: "@@@1")));
    final getDataSearch = ref.watch(cont);
    return Scaffold(
      key: _scaffoldKey,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                    child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      SizedBox(
                        // width: MediaQuery.of(context).size.width * 0.9,
                        height: 54,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(width: 5),
                            GestureDetector(
                              child: const Icon(Icons.arrow_back_ios),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
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
                                        borderSide: const BorderSide(
                                            color: Colors.grey))),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (_scaffoldKey.currentState!.isDrawerOpen) {
                                  _scaffoldKey.currentState!.closeDrawer();
                                  //close drawer, if drawer is open
                                } else {
                                  _scaffoldKey.currentState!.openEndDrawer();
                                  //open drawer, if drawer is closed
                                }
                              },
                              icon: const Icon(Icons.tune),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                          child: getDataSearch.results.isNotEmpty
                              ?
                          GridView.builder(
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            controller: _scrollController,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 1.0,
                                childAspectRatio: 0.56),
                            itemCount: getDataSearch.results.length,
                            itemBuilder: (context, index) => index < getDataSearch.results.length
                                ? GestureDetector(
                              onTap: () {
                                try {
                                  log("3333");
                                } catch (e) {
                                  log(e.toString());
                                }
                                ref.read(boolIsFavourite.notifier).state =
                                    getDataSearch.results[index].isFavorite;
                                MyWidgets.getDefaultStateDetailPage(ref: ref);
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
                                padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                                margin: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // const SizedBox(height: 5),
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
                                            physics:
                                            const NeverScrollableScrollPhysics(),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.network(
                                                height: 170,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.44,
                                                getDataSearch.results[index].photo
                                                    .toString(),
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
                                                      .updateFavorite(getDataSearch
                                                      .results[index].id
                                                      .toString());

                                                  ref
                                                      .read(cont.notifier)
                                                      .updateFavorite(getDataSearch
                                                      .results[index].id
                                                      .toString());

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
                                                    getDataSearch.results[index].isFavorite
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
                                    Text(getDataSearch.results[index].name.toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true),
                                    const SizedBox(height: 8),
                                    Visibility(
                                      visible: getDataSearch.results[index].rating == -1
                                          ? true
                                          : false,
                                      child: SizedBox(
                                        height: 30,
                                        child: Row(children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow.shade600,
                                          ),
                                          Text(getDataSearch.results[index].rating
                                              .toString()),

                                          /// Qo'shimcha qo'shish uchun
                                        ]),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${getDataSearch.results[index].price} \$",
                                                  style: const TextStyle(
                                                      decoration:
                                                      TextDecoration.lineThrough,
                                                      fontSize: 12)),
                                              Text( "${getDataSearch.results[index].price.toStringAsFixed(2)} \$",
                                                  style:
                                                  const TextStyle(fontSize: 12)),
                                            ],
                                          ),
                                          Container(
                                            // padding: const EdgeInsets.all(5),
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
                                                      if(getDataSearch.results[index].isCart){
                                                        ref
                                                            .read(
                                                            setFavourite2.notifier)
                                                            .setOrder(
                                                            idOrder: getDataSearch.results[index].id.toString() ,
                                                            count: "0",
                                                            colorProduct:
                                                            "",
                                                            sizeProduct:
                                                            "");


                                                        ref
                                                            .read(
                                                            cont.notifier)
                                                            .setOrders(
                                                            idOrder: getDataSearch.results[index].id.toString());

                                                      }else{
                                                        MyWidgets.bottomSheetDetails(
                                                            idProduct: getDataSearch
                                                                .results[index].id
                                                                .toString(),
                                                            isFavourite: getDataSearch
                                                                .results[index]
                                                                .isFavorite,
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
                                                        color:
                                                        getDataSearch.results[index].isCart
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
                          // GridView.builder(
                          //         shrinkWrap: true,
                          //         gridDelegate:
                          //         const SliverGridDelegateWithFixedCrossAxisCount(
                          //             crossAxisCount: 2,
                          //             mainAxisSpacing: 4.0,
                          //             crossAxisSpacing: 1.0,
                          //             childAspectRatio: 0.54),
                          //         scrollDirection: Axis.vertical,
                          //         controller: _scrollController,
                          //         itemCount: getDataSearch.results.length
                          //         // % 2 == 0
                          //         // ? getDataSearch.length + 2
                          //         // : getDataSearch.length + 3
                          //         ,
                          //         physics:
                          //             const AlwaysScrollableScrollPhysics(),
                          //         itemBuilder: (context, index) => index <
                          //                 getDataSearch.results.length
                          //             ? GestureDetector(
                          //                 onTap: () {
                          //                   ref.read(boolIsFavourite.notifier).state =  getDataSearch
                          //                       .results[index]
                          //                       .isFavorite;
                          //                   MyWidgets.getDefaultStateDetailPage(ref: ref);
                          //                   pushNewScreen(context,
                          //                       screen: DetailsPage(
                          //                         idProduct: getDataSearch
                          //                             .results[index].id
                          //                             .toString(),
                          //                         isFavourite: getDataSearch
                          //                             .results[index]
                          //                             .isFavorite,
                          //                         idProduct2: "",
                          //                       ),
                          //                       withNavBar: false);
                          //                   log(index.toString());
                          //                 },
                          //                 child: Container(
                          //                   padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                          //                   margin: const EdgeInsets.fromLTRB(7, 3, 7, 3),
                          //                   child: Column(
                          //                     mainAxisAlignment: MainAxisAlignment.start,
                          //                     crossAxisAlignment: CrossAxisAlignment.start,
                          //                     children: [
                          //                       const SizedBox(height: 2),
                          //                       Container(
                          //                         width:
                          //                         MediaQuery.of(context).size.width * 0.45,
                          //                         decoration: BoxDecoration(
                          //                             borderRadius: BorderRadius.circular(8),
                          //                             boxShadow: [
                          //                               BoxShadow(
                          //                                   blurRadius: 1,
                          //                                   color: Colors.grey.shade100,
                          //                                   offset: const Offset(1, 0),
                          //                                   spreadRadius: 10)
                          //                             ]),
                          //                         child: Stack(
                          //                           children: [
                          //                             SingleChildScrollView(
                          //                               physics:
                          //                                   const NeverScrollableScrollPhysics(),
                          //                               child: ClipRRect(
                          //                                 borderRadius:
                          //                                     BorderRadius
                          //                                         .circular(10),
                          //                                 child: Image.network(
                          //                                   height: 180,
                          //                                   width: MediaQuery.of(
                          //                                               context)
                          //                                           .size
                          //                                           .width *
                          //                                       0.44,
                          //                                   getDataSearch
                          //                                       .results[index]
                          //                                       .photo
                          //                                       .toString(),
                          //                                   fit: BoxFit.cover,
                          //                                   errorBuilder: (context,
                          //                                           error,
                          //                                           stackTrace) =>
                          //                                       SizedBox(
                          //                                     height: 160,
                          //                                     width: MediaQuery.of(
                          //                                                 context)
                          //                                             .size
                          //                                             .width *
                          //                                         0.4,
                          //                                     child: Image.asset(
                          //                                         height: 160,
                          //                                         "assets/images/shopping1.png"),
                          //                                   ),
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                             Row(
                          //                               mainAxisAlignment:
                          //                                   MainAxisAlignment
                          //                                       .end,
                          //                               children: [
                          //                                 GestureDetector(
                          //                                   onTap: () {
                          //                                     ref
                          //                                         .read(setFavourite2
                          //                                             .notifier)
                          //                                         .updateFavorite(getDataSearch
                          //                                             .results[
                          //                                                 index]
                          //                                             .id
                          //                                             .toString());
                          //                                     ref
                          //                                         .read(cont
                          //                                             .notifier)
                          //                                         .updateFavorite(getDataSearch
                          //                                             .results[
                          //                                                 index]
                          //                                             .id
                          //                                             .toString());
                          //                                   },
                          //                                   child: Container(
                          //                                     alignment:
                          //                                         Alignment
                          //                                             .topRight,
                          //                                     height: 42,
                          //                                     width: 42,
                          //                                     color: Colors
                          //                                         .transparent,
                          //                                     padding:
                          //                                         const EdgeInsets
                          //                                                 .fromLTRB(
                          //                                             10,
                          //                                             10,
                          //                                             10,
                          //                                             15.0),
                          //                                     child: Icon(
                          //                                       getDataSearch
                          //                                               .results[
                          //                                                   index]
                          //                                               .isFavorite
                          //                                           ? Icons
                          //                                               .favorite
                          //                                           : Icons
                          //                                               .favorite_border,
                          //                                       color:
                          //                                           Colors.red,
                          //                                     ),
                          //                                   ),
                          //                                 ),
                          //                               ],
                          //                             )
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       const SizedBox(height: 10),
                          //                       Text(
                          //                           getDataSearch
                          //                               .results[index].name
                          //                               .toString(),
                          //                           maxLines: 2,
                          //                           overflow:
                          //                               TextOverflow.ellipsis,
                          //                           softWrap: true),
                          //                       const SizedBox(height: 8),
                          //                       Visibility(
                          //                         visible: getDataSearch
                          //                                     .results[index]
                          //                                     .rating ==
                          //                                 -1
                          //                             ? true
                          //                             : false,
                          //                         child: SizedBox(
                          //                           height: 30,
                          //                           child: Row(children: [
                          //                             Icon(
                          //                               Icons.star,
                          //                               color: Colors
                          //                                   .yellow.shade600,
                          //                             ),
                          //                             Text(getDataSearch
                          //                                 .results[index].rating
                          //                                 .toString()),
                          //
                          //                             /// Qo'shimcha qo'shish uchun
                          //                           ]),
                          //                         ),
                          //                       ),
                          //                       const SizedBox(height: 5),
                          //                       Padding(
                          //                         padding:
                          //                             const EdgeInsets.only(
                          //                                 left: 1, right: 1),
                          //                         child: Row(
                          //                           mainAxisAlignment:
                          //                               MainAxisAlignment
                          //                                   .spaceBetween,
                          //                           children: [
                          //                             Column(
                          //                               mainAxisAlignment:
                          //                                   MainAxisAlignment
                          //                                       .start,
                          //                               crossAxisAlignment:
                          //                                   CrossAxisAlignment
                          //                                       .start,
                          //                               children: [
                          //                                 Text(
                          //                                     "${getDataSearch.results[index].price} so'm",
                          //                                     style:
                          //                                         const TextStyle(
                          //                                       decoration:
                          //                                           TextDecoration
                          //                                               .lineThrough,
                          //                                           fontSize: 13
                          //                                     )),
                          //                                 Text(
                          //                                     "${getDataSearch.results[index].newPrice.toStringAsFixed(2)} so'm", style:
                          //                                 const TextStyle(
                          //
                          //                                     fontSize: 13
                          //                                 )),
                          //                               ],
                          //                             ),
                          //                             Container(
                          //                                 // padding: const EdgeInsets.all(5),
                          //                                 decoration:
                          //                                     BoxDecoration(
                          //                                         shape: BoxShape
                          //                                             .circle,
                          //                                         border: Border
                          //                                             .all(
                          //                                           color: getDataSearch.results[index].slug ==
                          //                                                   "987654321"
                          //                                               ? Colors
                          //                                                   .red
                          //                                               : Colors
                          //                                                   .grey
                          //                                                   .shade400,
                          //                                         )),
                          //                                 child: Center(
                          //                                     child:
                          //                                         GestureDetector(
                          //                                   onTap: () {
                          //                                     ref
                          //                                         .read(setFavourite2
                          //                                             .notifier)
                          //                                         .setOrder(
                          //                                             idOrder: getDataSearch
                          //                                                 .results[
                          //                                                     index]
                          //                                                 .id
                          //                                                 .toString(),
                          //                                     count: "-1",
                          //                                         sizeProduct: ref.read(sizeSelectProduct).toString(),
                          //                                         colorProduct: ref.read(colorSelectProduct).toString()
                          //
                          //                                     );
                          //
                          //                                     ref
                          //                                         .read(cont
                          //                                             .notifier)
                          //                                         .setOrders(
                          //                                             idOrder: getDataSearch
                          //                                                 .results[
                          //                                                     index]
                          //                                                 .id
                          //                                                 .toString());
                          //                                   },
                          //                                   child: Container(
                          //                                     width: 42,
                          //                                     height: 45,
                          //                                     color: Colors
                          //                                         .transparent,
                          //                                     child: Icon(
                          //                                       Icons
                          //                                           .add_shopping_cart,
                          //                                       color: getDataSearch
                          //                                                   .results[
                          //                                                       index]
                          //                                                   .slug ==
                          //                                               "987654321"
                          //                                           ? Colors.red
                          //                                           : Colors
                          //                                               .grey
                          //                                               .shade800,
                          //                                       size: 20,
                          //                                     ),
                          //                                   ),
                          //                                 ))),
                          //                           ],
                          //                         ),
                          //                       ),
                          //
                          //                     ],
                          //                   ),
                          //                 ),
                          //               )
                          //             : const LoadingShimmer(),
                          //       )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          color: Colors.white,
                                          child: Image.asset(
                                            "assets/images/shopping1.png",
                                            height: 120,
                                          )),
                                      const SizedBox(height: 20),
                                      const Text("Ma'lumot topilmadi !!!"),
                                    ],
                                  ),
                                ))
                    ],
                  ),
                )))),
      endDrawer: Filter(),

    );
  }
}
