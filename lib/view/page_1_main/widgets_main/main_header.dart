import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/view/page_1_main/controller_main_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/controller_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/details_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/show_brands/show_brands.dart';
import 'package:shopping/widgets/app_widget/app_widgets.dart';
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

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 1),
          child: CarouselSlider(
              options: CarouselOptions(
                height: 250,
                aspectRatio: 3,
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
                          ref.read(boolIsFavourite.notifier).state = i.isActive;
                          MyWidgets.getDefaultStateDetailPage(ref: ref);
                          pushNewScreen(context,
                              screen: DetailsPage(
                                boolShowStore: true,
                                idProduct: i.id.toString(),
                                isFavourite: i.isActive,
                                idProduct2: "",
                              ),
                              withNavBar: false);
                        },
                        child: CachedNetworkImage(
                          // filterQuality: FilterQuality.medium,
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          alignment: Alignment.topCenter,
                          fit: BoxFit.cover,
                          imageUrl: i.image,
                          errorWidget: (context, url, text) {
                            return Image.asset(
                              "assets/images/shopping1.png",
                              fit: BoxFit.cover,
                            );
                          },
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  const LoadingShimmer(),
                        ),
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
        const SizedBox(height: 10),
        SizedBox(
            height: 60,
            child: getDataBanner.when(data: (data) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.results.length,
                itemBuilder: (context, index) => Container(
                    height: 55,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 1,
                              spreadRadius: 1)
                        ],
                        borderRadius: BorderRadius.circular(5)),
                    margin: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                    padding: const EdgeInsets.all(1),
                    child: Center(
                      child: GestureDetector(
                          onTap: () async {
                            box.delete("brand");
                            box.put("brand", data.results[index].id.toString());
                            pushNewScreen(context,
                                withNavBar: false,
                                screen: ShowBrands(
                                    brandName:
                                        data.results[index].name.toString(),
                                    brandId:
                                        data.results[index].id.toString()));
                          },
                          child: Column(
                            children: [
                              Container(
                                color: Colors.white,
                                margin: const EdgeInsets.all(3),
                                child: CachedNetworkImage(
                                  // filterQuality: FilterQuality.medium,
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  fit: BoxFit.fill,
                                  imageUrl: data.results[index].icon,
                                  errorWidget: (context, url, text) {
                                    return Image.asset(
                                      "assets/images/shopping1.png",
                                      fit: BoxFit.cover,
                                    );
                                  },
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          const LoadingShimmer(),
                                ),
                              ),
                              // SizedBox(
                              //     width: 40,
                              //     child: Text(data.results[index].name
                              //         .toString(), style: TextStyle(fontSize: 12),)),
                            ],
                          )),
                    )),
              );
            }, error: (error, errorText) {
              return Text(errorText.toString());
            }, loading: () {
              return const Text("Loading");
            })),
        // const SizedBox(height: 10),
      ],
    );
  }
}
