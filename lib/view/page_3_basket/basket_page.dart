import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/data/model/model_3_basket/model_basket_get_all.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/view/page_3_basket/basket_empty.dart';
import 'package:shopping/view/page_3_basket/controller_basket.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class BasketPage extends ConsumerStatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  ConsumerState<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends ConsumerState<BasketPage>
    with SingleTickerProviderStateMixin {
  var box = Hive.box("online");
  late ModelBasketList modelBasketList;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final listOrder = ref.watch(setFavourite2);
    // Tab(
    //   text: "basket".tr(),
    // ),
    // Tab(
    // text: "orders".tr(),
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 0,
          title: Text("basket".tr(),
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15, left: 15),
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                        child: MaterialButton(
                      color:
                      ref.watch(getIndexTabBarView) ==0?
                      Colors.red:Colors.white,
                      height: 50,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.transparent)),
                           onPressed: () {
                             ref.read(getIndexTabBarView.notifier).state = 0;
                             _tabController.animateTo(0);
                           },
                           child: Text("basket".tr(),
                          style:  TextStyle(
                              fontWeight: FontWeight.bold, color:
                          ref.watch(getIndexTabBarView) ==0?
                          Colors.white:Colors.black)),
                    ) ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: MaterialButton(
                          color:
                          ref.watch(getIndexTabBarView) ==1?
                          Colors.red:Colors.white,
                          height: 50,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                              const BorderSide(color: Colors.transparent)),
                          onPressed: () {
                            ref.read(getIndexTabBarView.notifier).state = 1;
                            _tabController.animateTo(1);
                          },
                          child: Text("orders".tr(),
                              style:  TextStyle(
                                  fontWeight: FontWeight.bold, color:
                              ref.watch(getIndexTabBarView) ==1?
                              Colors.white:Colors.black)),
                        ) ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics:const NeverScrollableScrollPhysics(),
                  children: [bodyBuild1(), bodyBuild1()],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton:
        ref.watch(getIndexTabBarView) == 0?
        modelBasketList.results.isNotEmpty
            ?
        FloatingActionButton(
                onPressed: () {
                  if (box.get("token").toString().length > 20) {
                    dialogAddOrder(productName: "setAllOrder".tr(), id: "");

                  } else {
                    MyWidgets.dialogNoToken(context: context);
                  }
                },
                backgroundColor: Colors.red,
                child: const Icon(
                  Icons.shopping_cart_checkout_sharp,
                  color: Colors.white,
                ),
              )
            : const SizedBox(): const SizedBox(),
      ),
    );
  }

  showModelDialog({required String productName, required String id}) {
    AwesomeDialog(
            context: context,
            title: "removeCart".tr(),
            dialogBackgroundColor: Colors.white,
            desc: productName,
            headerAnimationLoop: false,
            dialogType: DialogType.noHeader,
            btnCancelText: "yes".tr(),
            btnOkText: "no".tr(),
            barrierColor: Colors.black.withOpacity(0.5),
            buttonsTextStyle: const TextStyle(color: Colors.black),
            // btnCancelIcon: Icons.delete_forever_rounded,
            btnCancelColor: Colors.grey[400],
            btnOkColor: Colors.grey[100],
            buttonsBorderRadius: BorderRadius.circular(10),
            btnCancelOnPress: () {
              ref.read(getOrder.notifier).deleteInBasketList(id: id);
            },
            btnOkOnPress: () {})
        .show();
  }

  dialogAddOrder({required String productName, required String id}) {
    AwesomeDialog(
        context: context,
        title: "UZBEK BAZAR",
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        dialogBackgroundColor: Colors.white,
        desc: productName,
        descTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        headerAnimationLoop: false,
        dialogType: DialogType.noHeader,
        btnCancelText: "no".tr(),
        btnOkText: "yes".tr(),
        barrierColor: Colors.black.withOpacity(0.5),
        buttonsTextStyle: const TextStyle(color: Colors.black),
        // btnCancelIcon: Icons.delete_forever_rounded,
        btnCancelColor: Colors.grey[100],
        btnOkColor: Colors.grey[400],
        buttonsBorderRadius: BorderRadius.circular(10),
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          ref.read(getOrder.notifier).orderRequest();
        }).show().then((value){
      ref.read(getIndexTabBarView.notifier).state = 1;
      _tabController.animateTo(ref.watch(getIndexTabBarView));
    });
  }

  Widget bodyBuild1() {
    final listOrder = ref.watch(getOrder);
    modelBasketList = listOrder;
    if (listOrder.internetStatePosition.toString() == "0") {
      /// loading
      return LoadingShimmerList(h: 120);
    } else if (listOrder.internetStatePosition.toString() == "1") {
      /// success
      return SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: listOrder.results.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: () async {
                        ref.watch(getOrder);
                      },
                      child: ListView.builder(
                        itemCount: listOrder.results.length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.all(3),
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 0.41,
                                    blurRadius: 1)
                              ]),
                          child: GestureDetector(
                            onTap: () {
                              // ref.read(boolIsFavourite.notifier).state =
                              //     listOrder.results[index].size;
                              MyWidgets.getDefaultStateDetailPage(ref: ref);
                              pushNewScreen(context,
                                  withNavBar: false,
                                  screen: DetailsPage(
                                    boolShowStore: true,
                                    idProduct: listOrder
                                        .results[index].product.id
                                        .toString(),
                                    isFavourite: false,
                                    idProduct2: "",
                                  ));
                            },
                            child: Row(
                              children: [
                                const SizedBox(width: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: Image.network(
                                    listOrder.results[index].product.photo
                                        .toString(),
                                    height: MediaQuery.of(context).size.height *
                                        0.18,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            SizedBox(
                                      height: 120,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      child: Image.asset(
                                          "assets/images/shopping1.png"),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: Text(
                                            listOrder
                                                .results[index].product.name
                                                .toString(),
                                            maxLines: 2,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          )),
                                      // SizedBox(
                                      //   height: 30,
                                      //   child: Row(
                                      //     children: [
                                      //       Icon(Icons.star,
                                      //           color: Colors
                                      //               .yellow.shade700,
                                      //           size: 18),
                                      //       const SizedBox(width: 10),
                                      //       Text(listOrder
                                      //           .results[index].product.price
                                      //           .toString())
                                      //     ],
                                      //   ),
                                      // ),
                                      // SizedBox(
                                      //     width: MediaQuery.of(context)
                                      //             .size
                                      //             .width *
                                      //         0.4,
                                      //     child: Text(
                                      //       "${listOrder.results[index].product.price.toString()} \$",
                                      //       style: const TextStyle(
                                      //         fontSize: 12,
                                      //         decoration: TextDecoration
                                      //             .lineThrough,
                                      //       ),
                                      //     )),
                                      Text(
                                          "${listOrder.results[index].product.price.toString()
                                          // .substring(  0, getList(l: listOrder.results)[index].price)
                                          } \$",
                                          style: const TextStyle()),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  // Color(
                                                  //     int.parse(listOrder.results[index]
                                                  //         .product.color1.code1
                                                  //         .substring(1, 7),
                                                  //     radix: 16) +
                                                  //     0xFF000000),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Container(
                                            height: 25,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: SizedBox(
                                                height: 25,
                                                width: 40,
                                                child: Center(
                                                    child: Text(
                                                  listOrder.results[index].id
                                                      .toString(),
                                                  maxLines: 1,
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      // Text(getCostAll(
                                      //     count:
                                      //         getList(l: listOrder.results)[index]
                                      //             .id
                                      //             .toString(),
                                      //     cost:
                                      //         getList(l: listOrder.results)[index]
                                      //             .price
                                      //             .toString()))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15.0),
                                        child: GestureDetector(
                                            onTap: () {
                                              showModelDialog(
                                                  id: listOrder
                                                      .results[index].product.id
                                                      .toString(),
                                                  productName: listOrder
                                                      .results[index].size.id
                                                      .toString());
                                            },
                                            child: Icon(Icons.delete,
                                                color: Colors.grey.shade700)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : basketEmpty(context: context)));
    } else {
      /// error
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(listOrder.errorText.toString(),
                textAlign: TextAlign.center, maxLines: 3),
            Text(
              "error".tr(),
            ),
            MaterialButton(
              onPressed: () {
                ref.read(getOrder.notifier).getBasketList();
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

  String getCostAll({required String count, required String cost}) {
    double allCost = double.parse(count) * double.parse(cost);
    return "$count  X  ${cost.substring(0, cost.indexOf(
          ".",
        ))}  = ${allCost.toStringAsFixed(2)} \$";
  }
}
