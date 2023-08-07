import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';
import 'package:shopping/view/page_1_main/pages_main3/best_seller/controller_best_seller.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class BestSellers extends StatefulWidget {
  const BestSellers({super.key});

  @override
  State<BestSellers> createState() => _BestSellersState();
}

class _BestSellersState extends State<BestSellers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RiverPagedBuilder<String, User>(
        firstPageKey: 'key',
        provider: customExampleProvider,
        firstPageProgressIndicatorBuilder: (context, controller) =>const LoadingGridView(),
        newPageProgressIndicatorBuilder:  (context, controller) =>const LoadingShimmer(),
        pullToRefresh: false,
        enableInfiniteScroll: true,
        itemBuilder: (context, item, index) => Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              Image.network(
                item.profilePicture,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(item.name, maxLines: 2, overflow: TextOverflow.fade, softWrap: true),
              const SizedBox(height: 8),
              SizedBox(

              child: Expanded(
                child: RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  wrapAlignment: WrapAlignment.start,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
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
            ),
              const SizedBox(height: 8),
              Text(item.quantity.toString()),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${item.summa} so'm"),
                    Container(
                      // margin: EdgeInsets.all(3),
                      padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade400)
                        ),
                        child: Center(child: Icon(Icons.add_shopping_cart,
                          color: Colors.grey.shade800,
                          size: 20,))),
                  ],
                ),
              ),

            ],
          ),
        ),
        pagedBuilder: (controller, builder) => PagedGridView(
          pagingController: controller,
          builderDelegate: builder,

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 16/26,
            crossAxisSpacing: 1,


          ),
        ),
      ),
    );
  }
}
