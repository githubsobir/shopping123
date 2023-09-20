import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/view/page_1_main/pages_main3/best_seller/controller_best_seller.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';

class BestSellers extends ConsumerStatefulWidget {
  const BestSellers({super.key});

  @override
  ConsumerState<BestSellers> createState() => _BestSellersState();
}

class _BestSellersState extends ConsumerState<BestSellers> {
  late ModelSearch modelSearch = ModelSearch();
  ScrollController _scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  getData({required String item, required WidgetRef ref}) async {
    ref.read(getDataBestSeller(ModelSearch(search: "")));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(builder: (context, ref, child) {
      final getList = ref.watch(setFavourite2);
      return Text(getList.results[3].name);
    }));
  }
}
