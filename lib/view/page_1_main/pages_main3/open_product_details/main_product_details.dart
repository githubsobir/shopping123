import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shopping/data/model/model_main_1_page/model_main_product_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/full_screen_view.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDetailsScreen extends StatefulWidget {
  static String routeName = "/item_detail";
  final List<ProductModel> data;
  final int itemIndex;

  const ItemDetailsScreen(
      {super.key, required this.data, required this.itemIndex});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  int selectColorIndex = 0;
  int selectSizeIndex = 0;
  List<Color> colors = [
    const Color(0xff20C997),
    const Color(0xffAF83F8),
    const Color(0xffE25563),
    const Color(0xff121212),
    const Color.fromRGBO(250, 250, 250, 3),
  ];
  List<String> sizes = [
    "S",
    "M",
    "L",
    "XL",
    "2XL",
    "",
  ];

  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  /// The alignment to be used next time the user scrolls or jumps to an item.
  double alignment = 0;

  @override
  Widget build(BuildContext context) {
    List<String> imagesList = [
      // widget.data[0].image.toString(),
      "https://sc02.alicdn.com/kf/Uc88eb97c6b134a078079d9ab0e5e2904M.jpg",
      "https://i.etsystatic.com/10570298/r/il/c3b149/1616240312/il_794xN.1616240312_g6md.jpg",
      "https://ae01.alicdn.com/kf/HTB17Nd3XBcXBuNjt_Xoq6xIwFXaV/Cotton-Cool-Design-3D-Tee-Shirts-Uzbekistan-Uzbekistani-T-Shirt-Country-National-Map-Flag-Fun-Novelty.jpg",
      "https://www.seekpng.com/png/detail/25-256357_green-clipart-tshirt-gelbes-t-shirt-clipart.png",
    ];
    // SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 3),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            appbar(context, imagesList),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      widget.data[widget.itemIndex].title.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        RatingBar.builder(
                          ignoreGestures: true,
                          itemSize: 20,
                          initialRating: 4.5,
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
                        Text("4.5"),
                      ],
                    ),
                    // const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       const Row(
                          children: [
                            Text(
                              "9909900.00",
                              style:  TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                             SizedBox(width: 10),
                            Text(
                              "9909900.00",
                              style:  TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border,
                              // color: Color(0xffF35383),
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 12),
                    const Divider(color: Color(0xffbbbaba), thickness: 1),
                    const SizedBox(height: 12),
                    const Text(
                      "Color:",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 45,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: colors.length ,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                log("index colors");
                                log(index.toString());
                                setState(() {
                                  itemScrollController.jumpTo(index: index);
                                  selectColorIndex = index;
                                });
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  border: selectColorIndex == index
                                      ? Border.all(
                                          width: 2,
                                          color: Colors.black,
                                        )
                                      : const Border(),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: colors[index],
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.75),
                      child: MaterialButton(
                        padding: const EdgeInsets.only(left: 0, top: 0),
                        onPressed: () {
                          setState(() {
                            selectColorIndex = colors.length;
                          });
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.clear,
                              size: 14,
                            ),
                            Text(
                              "Clear",
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Text(
                      "Size",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 45,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sizes.length - 1,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectSizeIndex = index;
                                });
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  border: selectSizeIndex == index
                                      ? Border.all(
                                          width: 2,
                                          color: Colors.black,
                                        )
                                      : Border.all(
                                          width: 2,
                                          color: const Color(0xffCBCBCB),
                                        ),
                                  // borderRadius: BorderRadius.circular(100),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Center(
                                        child: Text(sizes[index].toString())),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.75),
                      child: MaterialButton(
                        padding: const EdgeInsets.only(left: 0, top: 0),
                        onPressed: () {
                          setState(() {
                            selectSizeIndex = sizes.length;
                          });
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.clear,
                              size: 14,
                            ),
                            Text(
                              "Clear",
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 24,
                          color: Colors.black,
                        ),
                        Text(
                          "Seller: ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Terra Pro",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 17,
                            fontWeight: FontWeight.w100,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ExpandableText(
                        label: "Description",
                        text: widget.data[widget.itemIndex].description),
                    const Text(
                      "Similar Items",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    // buildSimilarItems(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: buildBottomSheet(),
    );
  }

  StaggeredGridView buildSimilarItems() {
    return StaggeredGridView.countBuilder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      crossAxisCount: 2,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ItemDetailsScreen(
                  itemIndex: index,
                  data: widget.data,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(15),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 100,
                      maxHeight: 250,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.data[index].image.toString(),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data[index].title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RatingBar.builder(
                            ignoreGestures: true,
                            itemSize: 15,
                            initialRating: (4.5),
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
                          Text("(count: 100"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.data[index].price.toStringAsFixed(2) +
                                (" \$"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      staggeredTileBuilder: (context) => const StaggeredTile.fit(1),
    );
  }

  SizedBox buildBottomSheet() {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 45,
                height: 40,
                child: MaterialButton(
                  padding: const EdgeInsets.only(left: 0),
                  onPressed: () {},
                  child: const Column(
                    children: [
                      Icon(LineIcons.alternateStore),
                      Text(
                        "Store",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                height: 40,
                width: 130,

                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.black45,
                      width: 2,
                    )),
                child: InkWell(
                  onTap: () {
                    launchUrl(Uri(scheme: "sms", path: "+998977177298"));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        LineIcons.weixinWechat,
                        color: Colors.white,
                      ),
                      Text(
                        "Chat Now",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: InkWell(
                  onTap: () {
                    launchUrl(Uri(scheme: "tel", path: "+998977177298"));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        LineIcons.alternatePhone,
                        color: Colors.white,
                      ),
                      Text(
                        "Call Now",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar appbar(BuildContext context, List<String> images) {
    return SliverAppBar(
      iconTheme: IconThemeData(color: Colors.black),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 25, top: 5),
          child: GestureDetector(
              onTap: () {

                pushNewScreen(context, screen: FullScreenView(imagesList: images), withNavBar: false);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             FullScreenView(imagesList: images)));
              },
              child: ScrollablePositionedList.builder(
                itemCount: images.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CachedNetworkImage(
                    filterQuality: FilterQuality.high,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    imageUrl: images[index],
                    errorWidget: (context, url, text) {
                      return Image.asset(
                        "assets/images/image_for_error.png",
                        fit: BoxFit.cover,
                      );
                    },
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            const LoadingShimmer()),
                // CachedNetworkImage(
                //   width: MediaQuery.of(context).size.width,
                //   imageUrl: images[index],
                //   fit: BoxFit.cover,
                //
                // ),
                itemScrollController: itemScrollController,
                scrollOffsetController: scrollOffsetController,
                itemPositionsListener: itemPositionsListener,
                scrollOffsetListener: scrollOffsetListener,
              )
              // Swiper(
              //     pagination:
              //     const SwiperPagination(builder: SwiperPagination.fraction),
              //     itemBuilder: (context, index) {
              //       return CachedNetworkImage(
              //         imageUrl: images[index],
              //         fit: BoxFit.contain,
              //       );
              //     },
              //     itemCount: images.length),
              ),
        ),
      ),
      // (inputHeight / 812.0) * screenHeight;
      expandedHeight: (MediaQuery.of(context).size.height / 812) * 400,
      backgroundColor: Colors.white,
      // const Color.fromARGB(255, 238, 238, 238),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: Container(
          height: 20,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(250, 250, 250, 3),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(70),
              topRight: Radius.circular(70),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 7),
              Container(
                height: 4,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(70),
                    topRight: Radius.circular(70),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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