// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shopping/data/model/model_details/model_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/controller_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/full_screen_view.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/mini_details/controller_mini_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/open_store_products/open_store_all_product.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/rating_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/similar_items/review_last.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/similar_items/similar_items.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDetailsScreen extends StatefulWidget {
  ModelDetails modelDetails;
  bool isFavourite;
  String index;
  bool boolShowStore;

  ItemDetailsScreen(
      {super.key,
      required this.index,
      required this.modelDetails,
      required this.isFavourite,
      required this.boolShowStore});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  int selectColorIndex = 0;
  int selectSizeIndex = 0;

  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  /// The alignment to be used next time the user scrolls or jumps to an item.
  double alignment = 0;

  List<ModelSelectItem> imageAllUrl = [];
  List<String> colorAll = [];
  bool isFavourites = false;

  var box = Hive.box("online");

  Map<int, int> mapImage = {};

  @override
  void initState() {
    for (int i = 0; i < widget.modelDetails.variables.length; i++) {
      for (int j = 0; j < widget.modelDetails.variables[i].media.length; j++) {
        imageAllUrl.add(ModelSelectItem(
            image: widget.modelDetails.variables[i].media[j].file,
            color: widget.modelDetails.variables[i].color ?? "",
            isActive: widget.modelDetails.variables[i].isActive,
            quantity: widget.modelDetails.variables[i].quantity.toString()));
      }
    }
    log(jsonEncode(imageAllUrl).toString());
    isFavourites = widget.isFavourite;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            appbar(context, imageAllUrl),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        widget.modelDetails.name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// rating
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showBottomSheetForRating(
                                    productName:
                                        widget.modelDetails.name.toString());
                              },
                              child: RatingBar.builder(
                                ignoreGestures: true,
                                itemSize: 20,
                                initialRating: 1,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Color(0xffFD7E14),
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                            ),
                            Text(widget.index.toString()),
                          ],
                        ),

                        /// like
                        Consumer(
                          builder: (context, ref, child) => GestureDetector(
                            onTap: () {
                              ref
                                  .read(setFavourite2.notifier)
                                  .updateFavorite(widget.index.toString());
                              ref.read(boolIsFavourite.notifier).state =
                                  !ref.read(boolIsFavourite);
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              height: 42,
                              width: 42,
                              color: Colors.transparent,
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 15.0),
                              child: Icon(
                                ref.watch(boolIsFavourite)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.modelDetails.price.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              widget.modelDetails.price.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(color: Color(0xffbbbaba), thickness: 1),
                    const SizedBox(height: 10),

                    /// color list
                    Consumer(
                      builder: (context, ref, child) => Container(
                        height: 75,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: ref.watch(noSelectColorMiniDetailsPage) == -1
                                ? Colors.white
                                : Colors.red.shade100,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("chooseColor".tr(),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15)),
                            const SizedBox(height: 4),
                            SizedBox(
                              height: 40,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.modelDetails.variables.length,
                                itemBuilder: (context, index) {
                                  return widget.modelDetails.variables[index]
                                              .color !=
                                          null
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              ref
                                                      .read(
                                                          colorSelectProductPage
                                                              .notifier)
                                                      .state =
                                                  widget.modelDetails
                                                      .variables[index].id
                                                      .toString();
                                              ref
                                                  .read(
                                                      selectColorMiniDetailsPage
                                                          .notifier)
                                                  .state = index;
                                              ref
                                                  .read(
                                                      noSelectColorMiniDetailsPage
                                                          .notifier)
                                                  .state = -1;
                                              log(imageAllUrl
                                                  .indexWhere((item) =>
                                                      item.color ==
                                                      widget
                                                          .modelDetails
                                                          .variables[index]
                                                          .color)
                                                  .toString());

                                              ///
                                              setState(() {
                                                itemScrollController.jumpTo(
                                                    index: imageAllUrl
                                                        .indexWhere((item) =>
                                                            item.color ==
                                                            widget
                                                                .modelDetails
                                                                .variables[
                                                                    index]
                                                                .color));
                                                selectColorIndex = index;
                                              });
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                border: ref.watch(
                                                            selectColorMiniDetailsPage) ==
                                                        index
                                                    ? Border.all(
                                                        width: 3,
                                                        color: Colors.red,
                                                      )
                                                    : Border.all(
                                                        width: 1,
                                                        color: Colors.grey,
                                                      ),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(1.0),
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    color: Color(int.parse(
                                                            widget
                                                                .modelDetails
                                                                .variables[
                                                                    index]
                                                                .color
                                                                .substring(
                                                                    1, 7),
                                                            radix: 16) +
                                                        0xFF000000),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    /// size list
                    ///
                    widget.modelDetails.size.isNotEmpty
                        ? Consumer(
                            builder: (context, ref, child) => Container(
                              height: 80,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color:
                                      ref.watch(noSelectSizeMiniDetailsPage) ==
                                              -1
                                          ? Colors.white
                                          : Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "chooseSize".tr(),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  const SizedBox(height: 5),
                                  widget.modelDetails.size.isNotEmpty
                                      ? SizedBox(
                                          height: 40,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                widget.modelDetails.size.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    ref
                                                        .read(
                                                            selectSizeMiniDetailsPage
                                                                .notifier)
                                                        .state = index;
                                                    ref
                                                        .read(
                                                            noSelectSizeMiniDetailsPage
                                                                .notifier)
                                                        .state = -1;
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: 45,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: ref.watch(
                                                                  selectSizeMiniDetailsPage) ==
                                                              index
                                                          ? Border.all(
                                                              width: 2,
                                                              color: Colors.red,
                                                            )
                                                          : Border.all(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                      // borderRadius: BorderRadius.circular(100),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: SizedBox(
                                                        height: 30,
                                                        width: 40,
                                                        child: Center(
                                                            child: Text(
                                                          widget.modelDetails
                                                              .size[index].name
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(height: 10),

                    /// store

                    Visibility(
                      visible: widget.boolShowStore,
                      child: SizedBox(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("seller".tr()),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration:
                                      BoxDecoration(color: Colors.grey.shade50),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.person_outline,
                                            size: 24,
                                            color: Colors.black,
                                          ),
                                          // Text(
                                          //   "seller".tr(),
                                          //   style:const TextStyle(
                                          //       color: Colors.black,
                                          //       fontSize: 18,
                                          //       fontWeight: FontWeight.w500),
                                          // ),
                                          const SizedBox(width: 5),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            child: Text(
                                              widget.modelDetails.organization
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 45,
                                        child: MaterialButton(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          onPressed: () {
                                            pushNewScreen(context,
                                                screen: OpenStoreAllProduct(
                                                  categoryId: widget
                                                      .modelDetails.category
                                                      .toString(),
                                                  parentId: widget
                                                      .modelDetails.id
                                                      .toString(),
                                                  categoryName:
                                                      widget.modelDetails.name,
                                                  organization: widget
                                                      .modelDetails.organization
                                                      .toString(),
                                                ));
                                          },
                                          child: Column(
                                            children: [
                                              const Icon(
                                                  LineIcons.alternateStore),
                                              Text(
                                                "store".tr(),
                                                style: const TextStyle(
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 1),
                                      const SizedBox(width: 1),
                                      Container(
                                        height: 40,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            launchUrl(Uri(
                                                scheme: "tel",
                                                path: "+998901234567"));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Icon(
                                                LineIcons.alternatePhone,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                "callNow".tr(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// description
                    const SizedBox(height: 10),
                    ExpandableText(
                        label: "description".tr(),
                        text: widget.modelDetails.desc.toString()),
                    const SizedBox(height: 10),
                    const Text(
                      "Similar Items",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),

                    SizedBox(
                      height: 330,
                      child: SimilarItems(
                          idDetail: widget.modelDetails.type.toString()),
                    ),
                    const SizedBox(height: 20),
                    const Text("Oxorgi ko'rilganlar",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 330,
                      child: ReviewItems(
                          type: widget.modelDetails.type.toString()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) => Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.grey[50], borderRadius: BorderRadius.circular(10)),
          child:
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     IconButton(
              //         onPressed: () {
              //           if (ref.watch(countMiniDetailsPage.notifier).state >
              //               1) {
              //             ref.watch(countMiniDetailsPage.notifier).state--;
              //           }
              //         },
              //         icon: const Icon(Icons.remove)),
              //     const SizedBox(width: 12),
              //     Text(ref.watch(countMiniDetailsPage).toString(),
              //         style: const TextStyle(fontWeight: FontWeight.bold)),
              //     const SizedBox(width: 12),
              //     IconButton(
              //         onPressed: () {
              //           ref.watch(countMiniDetailsPage.notifier).state++;
              //         },
              //         icon: const Icon(Icons.add)),
              //   ],
              // ),
              MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: Colors.red,
            onPressed: () {
              getActionCheck(
                  ref: ref, idProduct: widget.modelDetails.id.toString());
            },
            height: 50,
            textColor: Colors.white,
            child: Text("addCart".tr()),
            // )
            // ],
          ),
        ),
      ),
      // bottomSheet: buildBottomSheet(),
    );
  }

  showBottomSheetForRating({required String productName}) {
    box.get("token").toString().length > 30
        ? showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            showDragHandle: true,
            backgroundColor: Colors.white,
            enableDrag: true,
            isDismissible: false,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            builder: (context) {
              return Container(
                  // margin:const EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height * 0.7,
                  color: Colors.white,
                  child: RatingPage(productName: productName));
            },
          )
        : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.white,
            duration: Duration(milliseconds: 1500),
            content: Text(
              "Ro'yxatdan o'tgan foydalanuvchilar izox qoldira oladi. ",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ));
  }

  getActionCheck({required WidgetRef ref, required String idProduct}) {
    if (ref.read(selectSizeMiniDetailsPage) > 0 &&
        ref.read(selectColorMiniDetailsPage) > 0) {
      ref.read(setFavourite2.notifier).setOrder(
          idOrder: idProduct.toString(),
          count: ref.read(countMiniDetailsPage).toString(),
          sizeProduct: ref.read(sizeSelectProductPage).toString(),
          colorProduct: ref.read(colorSelectProductPage).toString());

      ref.read(sendServer.notifier).setCartWithProductId(
          idProduct: idProduct,
          sizeId: ref.read(sizeId),

          colorId:ref.read(colorId) ,
          colorProduct: ref.read(colorSelectProductPage),
          countProduct: ref.read(countMiniDetailsPage).toString(),
          sizeProduct: ref.read(sizeSelectProductPage));

      // Navigator.of(context).pop();
    } else {
      if (ref.read(selectSizeMiniDetailsPage) == -1) {
        ref.read(noSelectSizeMiniDetailsPage.notifier).state = 1;
      }

      if (ref.read(selectColorMiniDetailsPage) == -1) {
        ref.read(noSelectColorMiniDetailsPage.notifier).state = 1;
      }
    }
  }

  SliverAppBar appbar(BuildContext context, List<ModelSelectItem> images) {
    return SliverAppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 25, top: 5),
          child: GestureDetector(
              onTap: () {
                pushNewScreen(context,
                    screen: FullScreenView(
                        imagesList: images,
                        pructName: widget.modelDetails.name),
                    withNavBar: false);
              },
              child: ScrollablePositionedList.builder(
                itemCount: images.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  log(index.toString());
                  return Stack(
                    children: [
                      index.toString() != "-1"
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                  filterQuality: FilterQuality.high,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.topCenter,
                                  imageUrl: images[index].image,
                                  errorWidget: (context, url, text) {
                                    return Center(
                                      child: Image.asset(
                                        "assets/images/image_for_error.png",
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          const LoadingShimmer()),
                            )
                          : Align(
                              alignment: Alignment.topCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/shopping1.png",
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                      index.toString() != "-1"
                          ? Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  images[index].quantity.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ))
                          : const SizedBox.shrink()
                    ],
                  );
                },
                itemScrollController: itemScrollController,
                scrollOffsetController: scrollOffsetController,
                itemPositionsListener: itemPositionsListener,
                scrollOffsetListener: scrollOffsetListener,
              )),
        ),
      ),
      expandedHeight: MediaQuery.of(context).size.height * 0.38,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CircleAvatar(
            backgroundColor: const Color.fromRGBO(250, 250, 250, 0.6),
            radius: 18,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                Share.share('UzbekBazar https://uzbekbazar.uz');
              },
              icon: const Icon(
                Icons.share,
                // color: Color(0xffF35383),
                color: Colors.black,
                size: 25,
              ),
            ),
          ),
        ),
      ],
      leading: CircleAvatar(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        radius: 18,
        child: IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            // color: Color(0xffF35383),
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
    );
  }
}

class ExpandableText extends StatelessWidget {
  const ExpandableText({
    super.key,
    required this.label,
    required this.text,
  });

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      header: Text(
        label.toString(),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      collapsed: const Text(""),
      expanded: Text(
        text.toString(),
        softWrap: true,
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      theme: const ExpandableThemeData(
        iconSize: 30,
        iconColor: Colors.black,
      ),
    );
  }
}

class ProDetailHeader extends StatelessWidget {
  final String label;

  const ProDetailHeader({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          ),
          Text(
            label,
            style: TextStyle(
                color: Colors.yellow.shade900,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}

///
class ModelSelectItem {
  String image;
  String color;
  dynamic size;
  String quantity;
  bool isActive;

  ModelSelectItem({
    required this.image,
    required this.color,
    this.size,
    required this.quantity,
    required this.isActive,
  });

  factory ModelSelectItem.fromJson(Map<String, dynamic> json) =>
      ModelSelectItem(
        image: json["image"],
        color: json["color"],
        size: json["size"],
        isActive: json["isActive"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "color": color,
        "size": size,
        "quantity": quantity,
        "isActive": isActive,
      };
}
