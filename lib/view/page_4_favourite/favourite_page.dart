// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/controller_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/view/page_4_favourite/controller_favourite.dart';
import 'package:shopping/view/page_4_favourite/favourite_empty.dart';
import 'package:shopping/view/page_4_favourite/favourite_page_items/grid_card_item.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class FavouritePage extends ConsumerStatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends ConsumerState<FavouritePage>
    with SingleTickerProviderStateMixin<FavouritePage> {
  ScrollController _scrollController = ScrollController();
  late AnimationController _slideAnimationController;

  late Animation<double> _heightFactorAnimation;
  final GlobalKey<AnimatedGridState> _gridKey = GlobalKey<AnimatedGridState>();

  @override
  initState() {
    _slideAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _heightFactorAnimation = CurvedAnimation(
        parent: _slideAnimationController.drive(
          //a Tween from 1.0 to 0.0 is what makes the slide effect by shrinking
          // the container using the [Align.heightFactor] parameter
          Tween<double>(
            begin: 1.0,
            end: 0.0,
          ),
        ),
        curve: Curves.ease);
    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    super.initState();
  }

  int pageCount = 1;

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      try {
        pageCount = pageCount + 1;
        log(pageCount.toString());
        // getData(item: pageCount.toString(), ref: ref);
        // log(getData(item: pageCount.toString(), ref: ref));
      } catch (e) {
        log(e.toString());
      }
    }
  }

  int skip = 0;
  bool shouldLoadMore = true;

  List<ResultProductList> getList({required List<ResultProductList> l}) {
    List<ResultProductList> listReturn = [];
    for (int i = 0; i < l.length; i++) {
      if (l[i].isFavorite.toString() == "true") {
        listReturn.add(l[i]);
      }
    }
    log(listReturn.length.toString());

    return listReturn;
  }

  Widget bodyBuild() {
    final listFavouriteList = ref.watch(getFavouriteList);
    if (listFavouriteList.boolDownloadCheck1.toString() == "0") {
      /// loading
      return const LoadingGridView();
    } else if (listFavouriteList.boolDownloadCheck1.toString() == "1") {
      /// success
      return listFavouriteList.results.isEmpty
          ? favouriteEmpty(context: context)
          : AnimationLimiter(
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                controller: _scrollController,
                itemCount: listFavouriteList.results.length,
                itemBuilder: (
                  context,
                  index,
                ) =>
                    index < listFavouriteList.results.length
                        ? AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 400),
                            columnCount: 2,
                            child: SlideAnimation(
                                delay: const Duration(milliseconds: 240),
                                child: FlipAnimation(
                                    delay: const Duration(milliseconds: 240),
                                    child: GestureDetector(
                                        onTap: () {
                                          ref
                                                  .read(boolIsFavourite.notifier)
                                                  .state =
                                              listFavouriteList
                                                  .results[index].isActive;
                                          MyWidgets.getDefaultStateDetailPage(
                                              ref: ref);
                                          pushNewScreen(context,
                                              screen: DetailsPage(
                                                boolShowStore: true,
                                                idProduct: listFavouriteList
                                                    .results[index].id
                                                    .toString(),
                                                isFavourite: listFavouriteList
                                                    .results[index].isActive,
                                                idProduct2: "",
                                              ),
                                              withNavBar: false);
                                          log(index.toString());
                                        },
                                        child: GridCartItem(
                                          resultModelNotifier:
                                              listFavouriteList.results[index],
                                        )))))
                        : const LoadingShimmer(),
                staggeredTileBuilder: (int index) {
                  return const StaggeredTile.fit(1);
                },
              ),
            );
    } else {
      /// error
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(listFavouriteList.errorText.toString()),
              Text("error".tr(),),
            MaterialButton(
              onPressed: () {
                ref.read(getFavouriteList.notifier).getFavouriteListFirst();
              },
              color: Colors.blue.shade800,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child:
                  Text("tryAgain".tr(), style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("favourite".tr(),

              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(child: bodyBuild()));
  }
}
