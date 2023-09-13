// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/view/page_2_category/page_2_controller.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class CategoryPageOpen extends ConsumerStatefulWidget {
  String categoryId;
  String parentId;
  String categoryName;

  CategoryPageOpen(
      {Key? key,
      required this.categoryId,
      required this.parentId,
      required this.categoryName})
      : super(key: key);

  @override
  ConsumerState<CategoryPageOpen> createState() => _CategoryPageOpenState();
}

class _CategoryPageOpenState extends ConsumerState<CategoryPageOpen> {
  int pageCount = 0;
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
    // _controller = ScrollController()..addListener(_scrollListener123);
  }

  late ModelSearch modelSearch;
  int value = 0;

  _scrollListener() async {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      try {
        log("1");
        modelSearch = ModelSearch(page: (pageCount + 1).toString(),
        category: widget.categoryId.toString()
        );
        // await  getData(modelSearch:  modelSearch, ref: ref);
        // if (value == 0) {
          await ref
              .read(getCategoryPage.notifier)
              .getDataCategoryPage(modelSearch: modelSearch);
        // } else {
        //   value = 1;
        // }
        // setState(() {
        //
        // });
      } catch (e) {
        log(e.toString());
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    final getData = ref.read(getCategoryPage);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryName,
              style: const TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Center(
            child:
            getData.results.isNotEmpty?
            ListView.builder(
              controller: _scrollController,
                itemCount: getData.results.length,
                itemBuilder: (context, index) =>
                    SizedBox(
                        height: 40,
                        child: Text(getData.results[index].name.toString())))
        :LoadingGridView()
        ));
  }
}
