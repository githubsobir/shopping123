import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class NewCollection extends ConsumerStatefulWidget {
  const NewCollection({super.key});

  @override
  ConsumerState<NewCollection> createState() => _NewCollectionState();
}

class _NewCollectionState extends ConsumerState<NewCollection> {

  int pageCount = 0;
 late ModelProductList data = ModelProductList(count: "", next: "", previous: "", results: []);
  ScrollController _scrollController = ScrollController();
  //
  // getData({required ModelSearch modelSearch, required WidgetRef ref}) async {
  // data = await ref.read(setFavourite2.notifier).getData(modelSearch: modelSearch);
  //  // await ref.watch(setFavourite2.notifier).getdata.results(modelSearch: modelSearch);
  //  //  setState(() {
  //  //
  //  //  });
  // }


  @override
  initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    _controller = ScrollController()..addListener(_scrollListener123);
  }

late ModelSearch modelSearch;
  int value = 0;
  _scrollListener() async{
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      try {
        modelSearch = ModelSearch(page: pageCount + 1);
      // await  getData(modelSearch:  modelSearch, ref: ref);
        if(value == 1) {
          await ref
              .read(setFavourite2.notifier)
              .getData(modelSearch: modelSearch);
        }else{
          value = 1;
        }
        // setState(() {
        //
        // });
      } catch (e) {
        log(e.toString());
      }
    }
  }

  int skip = 0;
  bool shouldLoadMore = true;
  ScrollController _controller = ScrollController();

  void _scrollListener123() {
    if (_controller.position.extentAfter == 0) {
    }
  }

  @override
  Widget build(BuildContext context) {
    final  getData =  ref.watch(setFavourite2);
    return Scaffold(
        body: ListView(
      children: [

        GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 0.55),
          scrollDirection: Axis.vertical,
          controller: _scrollController,
          itemCount: getData.results.length % 2 == 0 ? getData.results.length + 2 : getData.results.length + 3,
          physics: const NeverScrollableScrollPhysics(),
          // AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) => index < getData.results.length
              ?
          GestureDetector(
                  onTap: () {
                    pushNewScreen(context,
                        screen: DetailsPage(
                          idProduct: getData.results[index].id.toString(),
                          isFavourite: getData.results[index].isFavorite,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 5),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Image.network(
                                  height: 150,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  getData.results[index].photo.toString(),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
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
                                              getData.results[index].id.toString());
                                          // setState(() {});
                                        },
                                        child: Icon(
                                          getData.results[index].isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.red,
                                        ))),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(getData.results[index].name.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            softWrap: true),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 30,
                          child: RatingBar.builder(
                            initialRating:
                                double.parse(getData.results[index].rating.toString()),
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
                        Text(index.toString()),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${getData.results[index].price} so'm"),
                              Container(
                                  // margin: EdgeInsets.all(3),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: getData.results[index].slug == "987654321"
                                            ? Colors.red
                                            : Colors.grey.shade400,
                                      )),
                                  child: Center(
                                      child: GestureDetector(
                                    onTap: () {
                                      ref.read(setFavourite2.notifier).setOrder(
                                          idOrder: getData.results[index].id.toString());
                                      // setState(() {});
                                    },
                                    child: Icon(
                                      Icons.add_shopping_cart,
                                      color: getData.results[index].slug == "987654321"
                                          ? Colors.red
                                          : Colors.grey.shade800,
                                      size: 20,
                                    ),
                                  ))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Center(
                  //     child: Card(
                  //         color: Colors.blue, child: Text(data.results[index].fanName)))
                )
              : const LoadingShimmer(),
        ),
      ],
    ));
  }
}
