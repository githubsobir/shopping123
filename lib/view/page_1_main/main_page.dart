import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopping/view/page_1_main/controller_main_page.dart';
import 'package:shopping/widgets/colors/app_colors.dart';
import 'package:shopping/widgets/error_pages/data_not_found.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  getData(){}
  @override
  Widget build(BuildContext context) {
    final carouselData = ref.watch(getDataCarousel);

    return Scaffold(
        appBar: AppBar(
            title: Text('UZ BAZAR'),
            elevation: 0,
            backgroundColor: MyColors.appColorBlue1()),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: (){
              return getData();
            },
            child: NestedScrollView(
                floatHeaderSlivers: false,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    // SliverAppBar(
                    //   backgroundColor: MyColors.appColorWhite(),
                    //   floating: false,
                    //   elevation: 0,
                    //   expandedHeight: 10,
                    //   foregroundColor: MyColors.appColorWhite(),
                    //   excludeHeaderSemantics: true,
                    // ),
                    SliverToBoxAdapter(
                        child:

                        carouselData.when(data: (data) {
                      return
                        Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 250,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.9,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 8),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 0,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: data.results.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      /// carusel action
                                    },
                                    child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color:
                                                      MyColors.appColorGrey400(),
                                                  blurRadius: 5,
                                                  spreadRadius: 0.1)
                                            ]),
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: CachedNetworkImage(
                                                  filterQuality:
                                                      FilterQuality.high,
                                                  height: 220,
                                                  fit: BoxFit.fill,
                                                  imageUrl: i.image,
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      const CupertinoActivityIndicator(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Text(
                                                            url.toString(),
                                                          )),
                                            ),
                                            // const SizedBox(height: 10),
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.5)),
                                                child: Text(
                                                  i.title,
                                                  maxLines: 2,
                                                  softWrap: true,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0,
                                                      fontFamily:
                                                          'Roboto-Medium'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
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
                    }))
                  ];
                },
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 8,
                          itemBuilder: (context, index) => Container(
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: MyColors.appColorGrey400(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text(
                                  "Kategoriyalar",
                                  style: TextStyle(),
                                ),
                              )),
                        ),
                      ),
                    ),
                    Expanded(
                        child: GridView.custom(
                      gridDelegate: SliverQuiltedGridDelegate(
                        crossAxisCount: 2,
                        mainAxisSpacing: 3,
                        crossAxisSpacing: 0,
                        repeatPattern: QuiltedGridRepeatPattern.inverted,
                        pattern: [
                          QuiltedGridTile(2, 1),
                          QuiltedGridTile(2, 1),
                          // QuiltedGridTile(1, 1),
                          // QuiltedGridTile(1, 1),
                        ],
                      ),
                      childrenDelegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            Card(child: Center(child: Text(index.toString()))),
                      ),
                    ))
                  ],
                )),
          ),
        ));
  }
}
