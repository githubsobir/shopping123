import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/controller_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/mini_details/controller_mini_details.dart';
import 'package:shopping/view/page_3_basket/basket_empty.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';

class BasketPage extends ConsumerStatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  ConsumerState<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends ConsumerState<BasketPage> {
  List<ResultProductList> getList({required List<ResultProductList> l}) {
    List<ResultProductList> listReturn = [];
    for (int i = 0; i < l.length; i++) {
      if (l[i].slug.toString() == "987654321") {
        listReturn.add(l[i]);
      }
    }

    return listReturn;
  }

  @override
  Widget build(BuildContext context) {
    // final listOrder = ref.watch(setFavourite2);
    final listOrder = ref.watch(setFavourite2);

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
              padding: const EdgeInsets.all(5),
              child: getList(l: listOrder.results).isNotEmpty
                  ? ListView.builder(
                      itemCount: getList(l: listOrder.results).length,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.all(3),
                        height: 180,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade400,
                                  spreadRadius: 0.41,
                                  blurRadius: 2)
                            ]),
                        child: GestureDetector(
                          onTap: () {
                            ref.read(boolIsFavourite.notifier).state = getList(l: listOrder.results)[index]
                                .isFavorite;
                            MyWidgets.getDefaultStateDetailPage(ref: ref);
                            pushNewScreen(context,
                                withNavBar: false,
                                screen: DetailsPage(
                                    idProduct:
                                        getList(l: listOrder.results)[index]
                                            .id
                                            .toString(),
                                    isFavourite:
                                        getList(l: listOrder.results)[index]
                                            .isFavorite,
                                idProduct2: "",
                                ));
                          },
                          child: Row(
                            children: [
                              const SizedBox(width: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: Image.network(
                                  getList(l: listOrder.results)[index]
                                      .photo
                                      .toString(),
                                  height:
                                      MediaQuery.of(context).size.height * 0.18,
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      SizedBox(
                                    height: 120,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Text(
                                          getList(l: listOrder.results)[index]
                                              .name
                                              .toString(),
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )),
                                    SizedBox(
                                      height: 30,
                                      child: Row(
                                        children: [
                                          Icon(Icons.star,
                                              color: Colors.yellow.shade700,
                                              size: 18),
                                          const SizedBox(width: 10),
                                          Text(getList(
                                                  l: listOrder.results)[index]
                                              .rating
                                              .toString())
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Text(
                                          "${getList(l: listOrder.results)[index].price} \$",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        )),
                                    Text(
                                        "${getList(l: listOrder.results)[index].newPrice.toString().substring(  0,
                                            getList(l: listOrder.results)[index].newPrice.toString().indexOf(".")
                                        ) } \$",
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
                                            padding: const EdgeInsets.all(1.0),
                                            child: Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                color: Color(int.parse(
                                                        ref
                                                            .read(getListDetails)[
                                                                index]
                                                            .color
                                                            .substring(1, 7),
                                                        radix: 16) +
                                                    0xFF000000),
                                                borderRadius:
                                                    BorderRadius.circular(100),
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
                                              color: const Color(0xffCBCBCB),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: SizedBox(
                                              height: 25,
                                              width: 40,
                                              child: Center(
                                                  child: Text(
                                                ref
                                                    .read(getListDetails)[index]
                                                    .size
                                                    .toString(),
                                                maxLines: 1,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(getCostAll(
                                        count:
                                            getList(l: listOrder.results)[index]
                                                .count
                                                .toString(),
                                        cost:
                                            getList(l: listOrder.results)[index]
                                                .newPrice
                                                .toString()))
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            showModelDialog(
                                                id: getList(
                                                        l: listOrder
                                                            .results)[index]
                                                    .id
                                                    .toString(),
                                                productName: getList(
                                                        l: listOrder
                                                            .results)[index]
                                                    .name
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
                    )
                  : basketEmpty(context: context))),
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
            barrierColor: Colors.white24,
            buttonsTextStyle: const TextStyle(  color:  Colors.black),
            // btnCancelIcon: Icons.delete_forever_rounded,
            btnCancelColor: Colors.grey[400],
            btnOkColor: Colors.grey[100],

            buttonsBorderRadius: BorderRadius.circular(10),
            btnCancelOnPress: () {
              ref.watch(setFavourite2.notifier).setOrder(
                  idOrder: id.toString(),
                  count: "0",
                  sizeProduct: ref.read(sizeSelectProduct).toString(),
                  colorProduct: ref.read(colorSelectProduct).toString());
            },
            btnOkOnPress: () {})
        .show();
  }

  String getCostAll({required String count, required String cost}) {
    double allCost = double.parse(count) * double.parse(cost);
    return "\$ ${allCost.toStringAsFixed(2)} =${cost.substring(0, cost.indexOf(
          ".",
        ))} x $count";
  }
}
