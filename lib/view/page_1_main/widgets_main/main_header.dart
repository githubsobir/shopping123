import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/view/page_1_main/controller_main_page.dart';
import 'package:shopping/widgets/colors/app_colors.dart';
import 'package:shopping/widgets/error_pages/data_not_found.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

Widget mainHeader({required BuildContext context, required WidgetRef ref}) {
  final carouselData = ref.watch(getDataCarousel);
  return SliverToBoxAdapter(
      child: carouselData.when(data: (data) {
    return Container(
      margin: const EdgeInsets.only(top: 1),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 320,
          aspectRatio: 16 / 9,
          viewportFraction: 1,
          initialPage: 0,

          //  animateToClosest: false,
          // padEnds: false,

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
        items: data.results.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  /// carusel action
                },
                child: Container(
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
                                  "assets/images/image_for_error.png",
                              fit: BoxFit.fill,
                              );
                            },
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    const LoadingShimmer(),
                            // errorWidget: (context, url, error) => Text(
                            //       url.toString(),
                            //     ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: MaterialButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
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
        }).toList(),
      ),
    );
  }, error: (error, errorTexts) {
    return DataNotFound(errorText: errorTexts.toString());
  }, loading: () {
    return const LoadingShimmer();
  }));
}
