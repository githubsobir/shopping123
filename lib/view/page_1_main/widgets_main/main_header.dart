import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/view/page_1_main/controller_main_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/controller_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/show_brands/show_brands.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
import 'package:shopping/widgets/colors/app_colors.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class HeaderMain extends ConsumerStatefulWidget {
  const HeaderMain({super.key});

  @override
  ConsumerState<HeaderMain> createState() => _HeaderMainState();
}

class _HeaderMainState extends ConsumerState<HeaderMain> {
  var box = Hive.box("online");

  @override
  Widget build(BuildContext context) {
    final carouselData = ref.watch(getDataCarousel);
    final getDataBanner = ref.watch(getDataNewCollection);
    ModelSearch modelSearch;
    return SliverToBoxAdapter(
        child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 1),
          child: CarouselSlider(
              options: CarouselOptions(
                height: 320,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 8),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0,
                scrollDirection: Axis.horizontal,
              ),
              items: carouselData.when(data: (data) {
                return data.results.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          ref.read(boolIsFavourite.notifier).state =  i.isActive;
                          MyWidgets.getDefaultStateDetailPage(ref: ref);
                          pushNewScreen(context,
                              screen: DetailsPage(
                                  idProduct: i.id.toString(),
                                  isFavourite: i.isActive,
                              idProduct2: "",
                              ),
                              withNavBar: false);
                        },
                        child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 1.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: MyColors.appColorGrey400(),
                                      blurRadius: 5,
                                      spreadRadius: 0.1)
                                ]),
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  filterQuality: FilterQuality.high,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  imageUrl: i.image,
                                  errorWidget: (context, url, text) {
                                    return Image.asset(
                                      "assets/images/shopping1.png",
                                      fit: BoxFit.fill,
                                    );
                                  },
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          const LoadingShimmer(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: MaterialButton(
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      height: 40,
                                      minWidth: 120,
                                      color: Colors.white,
                                      child: Text("more".tr()),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      );
                    },
                  );
                }).toList();
              }, error: (error, errorText) {
                return [const Text("error")];
              }, loading: () {
                return [const Text("loading")];
              })),
        ),
        SizedBox(
            height: 50,
            child: getDataBanner.when(data: (data) {
              return Row(
                children: [
                  GestureDetector(
                    child: Container(
                        height: 45,
                        width: 60,
                        margin: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 1,
                                  spreadRadius: 1)
                            ],
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(child: Text("All"))),
                    onTap: () {
                      modelSearch = ModelSearch();
                      ref
                          .read(setFavourite2.notifier)
                          .getData(modelSearch: modelSearch);
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.results.length,
                      itemBuilder: (context, index) => Container(
                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 1,
                                    spreadRadius: 1)
                              ],
                              borderRadius: BorderRadius.circular(5)),
                          margin: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                          padding: const EdgeInsets.all(3),
                          child: Center(
                            child: GestureDetector(
                                onTap: () async {
                                  // modelSearch = ModelSearch(
                                  //     brand: data.results[index].id.toString());
                                  // ref
                                  //     .read(setFavourite2.notifier)
                                  //     .getData(modelSearch: modelSearch);
                                  //
                                  box.delete("brand");
                                  box.put("brand",
                                      data.results[index].id.toString());
                                  pushNewScreen(context,
                                      withNavBar: false,
                                      screen: ShowBrands(
                                          brandName: data.results[index].title
                                              .toString(),
                                          brandId: data.results[index].id
                                              .toString()));
                                },
                                child:
                                    Text(data.results[index].title.toString())),
                          )),
                    ),
                  )
                ],
              );
            }, error: (error, errorText) {
              return Text(errorText.toString());
            }, loading: () {
              return Text("Loading");
            })),
        const SizedBox(height: 10),
      ],
    ));
  }
}
