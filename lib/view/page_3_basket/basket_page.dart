import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/view/page_3_basket/controller_basket.dart';

class BasketPage extends ConsumerStatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends ConsumerState<BasketPage> {
  @override
  Widget build(BuildContext context) {
    final listOrder = ref.watch(getOrder.notifier).getOrder();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("basket".tr(),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(1),
              child: ListView.builder(
                itemCount: listOrder.length,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(3),
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 0.41,
                            blurRadius: 2)
                      ]),
                  child: GestureDetector(
                    onTap: (){
                      pushNewScreen(context, screen: DetailsPage(
                          idProduct: listOrder[index].id.toString(),
                          isFavourite: listOrder[index].isFavorite));
                    },
                    child: Row(
                      children: [
                        Image.network(
                          listOrder[index].photo,
                          width: 120,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    listOrder[index].name.toString(),
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  )),
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
                                  onRatingUpdate: (rating) {},
                                ),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    listOrder[index].price.toString(),
                                    style: TextStyle(fontSize: 15),
                                  )),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: GestureDetector(
                                    onTap: () {
                                      ref.watch(getOrder.notifier).setOrder(
                                          idOrder:
                                              listOrder[index].id.toString());
                                      setState(() {

                                      });
                                    },
                                    child: Icon(Icons.delete,
                                        color: Colors.red.shade700)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ))),
    );
  }
}
