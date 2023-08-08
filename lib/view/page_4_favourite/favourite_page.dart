import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';
import 'package:shopping/data/model/model_main_1_page/model_main_product_details.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shopping/view/page_1_main/pages_main3/best_seller/controller_best_seller.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/main_product_details.dart';
import 'package:shopping/widgets/colors/app_colors.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("favourite".tr(),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Padding(padding: EdgeInsets.all(8), child:  RiverPagedBuilder<String, ProductModel>(
            firstPageKey: 'key',
            provider: customExampleProvider,
            firstPageProgressIndicatorBuilder: (context, controller) =>
            const LoadingGridView(),
            newPageProgressIndicatorBuilder: (context, controller) =>
            const LoadingShimmer(),
            pullToRefresh: false,
            enableInfiniteScroll: true,
            itemBuilder: (context, item, index) =>
                GestureDetector(
                  onTap: () {
                    pushNewScreen(context, screen: ItemDetailsScreen(
                        itemIndex: 0,
                        data: [ProductModel(image: "https://cdn-images.farfetch-contents.com/19/88/58/50/19885850_50455986_1000.jpg",
                          title: "titles",
                          category: 1,
                          description: "description descriptiondescriptiondescriptiondescriptiondescription descriptiondescription",
                          id: 1,
                          price: "999 0000",
                          rating: "4.5",
                        )]),
                        withNavBar: false
                    );
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 5),
                        Stack(
                          children: [
                            Image.network(
                              item.image,
                              fit: BoxFit.cover,
                            ),
                            Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                    onTap: () {

                                    },
                                    child:  Icon(Icons.favorite, color: MyColors.appColorUzBazar(),)))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(item.title,
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
                            itemPadding: const EdgeInsets.symmetric(
                                horizontal: 1.0),
                            itemSize: 16,
                            itemBuilder: (context, _) =>
                            const Icon(
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
                        Text(item.id.toString()),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${item.price} so'm"),
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
            pagedBuilder: (controller, builder) =>
                PagedGridView(
                  pagingController: controller,
                  builderDelegate: builder,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 16 / 26,
                    crossAxisSpacing: 1,
                  ),
                ),
          ),)),
    );
  }
}
