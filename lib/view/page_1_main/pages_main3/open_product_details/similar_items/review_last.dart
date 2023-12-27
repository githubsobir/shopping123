// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/data/model/model_details/model_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
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
  void initState() {
    getData();
    super.initState();
  }

  List<ModelDetails> listModelDetails = [];

  getData() async {
    try {
      listModelDetails = box.get("listLastView").toString().length > 4
          ? (jsonDecode(box.get("listLastView")) as List)
              .map((e) => ModelDetails.fromJson(e))
              .toList()
          : [];
    } catch (e) {
      log(e.toString());
    }
  }

  deleteLastView(int index) {
    listModelDetails = box.get("listLastView").toString().length > 4
        ? (jsonDecode(box.get("listLastView")) as List)
            .map((e) => ModelDetails.fromJson(e))
            .toList()
        : [];
    listModelDetails.removeAt(index);
    box.put("listLastView", jsonEncode(listModelDetails).toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: ListView.builder(
        itemCount: listModelDetails.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => index < listModelDetails.length
            ? GestureDetector(
                onTap: () {
                  MyWidgets.getDefaultStateDetailPage(ref: ref);
                  pushNewScreen(context,
                      screen: DetailsPage(
                        boolShowStore: true,
                        idProduct: listModelDetails[index].id.toString(),
                        idProduct2: "",
                        isFavourite: false,
                      ),
                      withNavBar: false);
                  log(index.toString());
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                  margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
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
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: 200,
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: listModelDetails[index]
                                          .variables
                                          .length,
                                      itemBuilder: (context, index2) =>
                                          ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: CachedNetworkImage(
                                          imageUrl: getImageLink(index, index2),
                                          height: 200,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          fit: BoxFit.cover,
                                          alignment: Alignment.topCenter,
                                          errorWidget: (context, error,
                                                  stackTrace) =>
                                              SizedBox(
                                                  height: 150,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: Image.asset(
                                                      "assets/images/shopping1.png")),
                                          // height: 100,
                                          // width: 150,
                                        ),
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 5, 15.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      ///delete
                                      deleteLastView(index);
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: const Icon(
                                        Icons.delete_outline_sharp,
                                        color: Colors.grey,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 120,
                          child: Text(listModelDetails[index].name.toString(),
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
                                Text(listModelDetails[index].rating.toString(),
                                    style: const TextStyle(fontSize: 14)),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${listModelDetails[index].price} \$"),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                // Center(
                //     child: Card(
                //         color: Colors.blue, child: Text(data[index].fanName)))
              )
            : const LoadingShimmer(),
      ),
    ));
  }

  String getImageLink(int index, int index2) {
    try {
      return listModelDetails[index].variables[0].media[index2].file;
    } catch (e) {
      return "";
    }
  }
}
