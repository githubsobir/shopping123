// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/controller_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/main_product_details.dart';
import 'package:easy_localization/easy_localization.dart';

class DetailsPage extends StatefulWidget {
  String idProduct;
  String idProduct2;
  bool isFavourite;
  bool boolShowStore;

  DetailsPage(
      {super.key,
      required this.idProduct,
      required this.isFavourite,
      required this.idProduct2,
      required this.boolShowStore});

  @override
  State<DetailsPage> createState() => _DatailsPageState();
}

class _DatailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 1,
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Colors.white,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
      ),
      body: SafeArea(child: Consumer(
        builder: (context, ref, child) {
          final getDetail = ref.watch(getDetails(widget.idProduct));
          return getDetail.when(data: (data) {
            return ItemDetailsScreen(
              boolShowStore: widget.boolShowStore,
              modelDetails: data,
              index: widget.idProduct.toString(),
              isFavourite: widget.isFavourite,
            );
          }, error: (error, errorText) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBar(
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(color: Colors.black),
                  elevation: 0,
                ),
                Image.asset("assets/images/shopping1.png", fit: BoxFit.cover),
                Text("errorGetInfo".tr()),

              ],
            ));
          }, loading: () {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          });
        },
      )),
    );
  }
}
