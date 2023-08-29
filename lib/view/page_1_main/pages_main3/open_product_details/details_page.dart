// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/controller_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/main_product_details.dart';

class DetailsPage extends StatefulWidget {
  String idProduct;
  // int indexs;
  bool isFavourite;

  DetailsPage({super.key,  required this.idProduct, required this.isFavourite});

  @override
  State<DetailsPage> createState() => _DatailsPageState();
}

class _DatailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Consumer(
        builder: (context, ref, child) {
          final getDetail = ref.watch(getDetails(widget.idProduct));
          return getDetail.when(data: (data) {
            return ItemDetailsScreen(modelDetails: data,
              index: widget.idProduct.toString(),
              isFavourite: widget.isFavourite ??false,);
          }, error: (error, errorText) {
            return Center(
              child: Text(errorText.toString()),
            );
          }, loading: () {
            return const Center(
              child: Text("Loading..."),
            );
          });
        },
      )),
    );
  }
}
