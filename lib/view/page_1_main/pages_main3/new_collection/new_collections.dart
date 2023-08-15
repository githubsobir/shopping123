import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';

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

  int pageCount = 1;

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      pageCount = pageCount + 1;
      getData(item: pageCount.toString(), ref: ref);
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
          itemCount: data.length,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                log(index.toString());
              },
              child: Center(
                  child: Card(
                      color: Colors.blue, child: Text(data[index].fanName)))),
        );
      }, error: (error, textError) {
        return Center(
          child: Text(textError.toString()),
        );
      }, loading: () {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      })),
    );
  }
}
