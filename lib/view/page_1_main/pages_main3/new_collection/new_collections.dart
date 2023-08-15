import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class NewCollection extends ConsumerStatefulWidget {
  const NewCollection({super.key});

  @override
  ConsumerState<NewCollection> createState() => _NewCollectionState();
}

class _NewCollectionState extends ConsumerState<NewCollection> {
  getData({required String item, required WidgetRef ref}) async {
    ref.watch(getDataInfinitiList(item));
  }

  ScrollController _scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  int pageCount = 0;

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      try {
        pageCount = pageCount + 1;
        log(pageCount.toString());
        getData(item: pageCount.toString(), ref: ref);
        // log(getData(item: pageCount.toString(), ref: ref));
      } catch (e) {}
    }
  }

  int skip = 0;
  bool shouldLoadMore = true;

  @override
  Widget build(BuildContext context) {
    final listGet = ref.watch(getDataInfinitiList("1"));
    return Scaffold(
      body: Center(
          child: listGet.when(data: (data) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          controller: _scrollController,
          itemCount: data.length % 2 == 0 ? data.length+ 2 :data.length+ 3,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) => index < data.length
              ? GestureDetector(
                  onTap: () {
                    log(index.toString());
                  },
                  child: Container(
                    height: 350,
                    width: 200,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 100,
                            child: Stack(
                              children: [
                                SingleChildScrollView(
                                  child: Image.network(
                                    data[index].qimg,
                                    fit: BoxFit.cover,
                                    // height: 100,
                                    // width: 150,
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                        onTap: () {},
                                        child:
                                            const Icon(Icons.favorite_border)))
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(data[index].bookNum.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              softWrap: true),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 30,
                            child: RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              wrapAlignment: WrapAlignment.start,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 1.0),
                              itemSize: 16,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 10,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text("4"),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("999 so'm"),
                                Container(
                                    // margin: EdgeInsets.all(3),
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.grey.shade400)),
                                    child: Center(
                                        child: Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.grey.shade800,
                                      size: 20,
                                    ))),
                              ],
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
        );
      }, error: (error, textError) {
        return Center(
          child: Text(textError.toString()),
        );
      }, loading: () {
        return const LoadingGridView();
      })),
    );
  }
}
