import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/view/page_2_category/category_page_open.dart';
import 'package:shopping/view/page_2_category/page_2_controller.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class NewItem {
  bool isExpanded;
  final String header;
  final Widget body;
  final Icon iconpic;

  NewItem(this.isExpanded, this.header, this.body, this.iconpic);
}

double discretevalue = 2.0;
double hospitaldiscretevalue = 25.0;

class _CategoryPageState extends State<CategoryPage> {
  int selected = -1; //attention
  int selected2 = -1; //attention
  int selected3 = -1; //attention
  int selected4 = -1; //attention
  int selected5 = -1; //attention
  int selected6 = -1; //attention
  var box = Hive.box("online");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title:  Text("category".tr(),
              style:
                  const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            return SafeArea(
                child: ref.watch(getCategoryData).when(data: (data) {
              return Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                      child: Column(children: [
                    ListView.builder(
                      key: Key('builder ${selected.toString()}'),
                      //attention
                      padding: const EdgeInsets.only(
                          left: 13.0, right: 13.0, bottom: 13.0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.results.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          const Divider(
                            height: 17.0,
                            color: Colors.white,
                          ),
                          data.results[index].subcategories.isNotEmpty
                              ? ExpansionTile(
                                  key: Key(index.toString()),
                                  initiallyExpanded: index == selected,
                                  leading: CachedNetworkImage(
                                    // filterQuality: FilterQuality.medium,
                                    width: 30,
                                    height: 30,
                                    alignment: Alignment.center,
                                    fit: BoxFit.cover,
                                    imageUrl: data.results[index].icon??"",
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
                                  title: Text(data.results[index].name,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold)),
                                  // subtitle: Text(
                                  //   data.results[index].id.toString(),
                                  //   style: const TextStyle(
                                  //       color: Colors.black,
                                  //       fontSize: 13.0,
                                  //       fontWeight: FontWeight.bold),
                                  // ),
                                  onExpansionChanged: ((newState) {
                                    if (newState) {
                                      setState(() {
                                        const Duration(seconds: 20000);
                                        selected = index;
                                        selected2 = -1;
                                      });
                                    } else {
                                      setState(() {
                                        selected = -1;
                                        selected2 = -1;
                                      });
                                    }
                                  }),
                                  children: [
                                    data.results[index].subcategories.isNotEmpty
                                        ? ListView.builder(
                                            itemCount: data.results[index]
                                                .subcategories.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index2) {
                                              /// 2-qavat

                                              return !data
                                                      .results[index]
                                                      .subcategories[index2]
                                                      .subcategories
                                                      .isNotEmpty
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Column(
                                                        children: [

                                                          ExpansionTile(
                                                            key: Key(("$selected2")
                                                                .toString()),
                                                            initiallyExpanded:
                                                                index2 == selected2,
                                                            title: Text(
                                                              data
                                                                  .results[index]
                                                                  .subcategories[
                                                                      index2]
                                                                  .name,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow.fade,
                                                              softWrap: true,
                                                            ),
                                                            onExpansionChanged:
                                                                ((newState) {
                                                              if (newState) {
                                                                setState(() {
                                                                  const Duration(
                                                                      seconds:
                                                                          20000);
                                                                  selected2 =
                                                                      index2;
                                                                });
                                                              } else {
                                                                setState(() {
                                                                  selected2 = -1;
                                                                });
                                                              }
                                                            }),
                                                            children: [
                                                              data
                                                                      .results[
                                                                          index]
                                                                      .subcategories[
                                                                          index2]
                                                                      .subcategories
                                                                      .isNotEmpty
                                                                  ?

                                                                  /// 3-qavat
                                                                  Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left: 15),
                                                                      child: ListView
                                                                          .builder(
                                                                        shrinkWrap:
                                                                            true,
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(),
                                                                        itemCount: data
                                                                            .results[
                                                                                index]
                                                                            .subcategories[
                                                                                index2]
                                                                            .subcategories
                                                                            .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index3) {
                                                                          return data
                                                                                  .results[index]
                                                                                  .subcategories[index2]
                                                                                  .subcategories[index3]
                                                                                  .subcategories
                                                                                  .isNotEmpty
                                                                              ? ExpansionTile(
                                                                                  title: Text(data.results[index].subcategories[index2].subcategories[index3].name),
                                                                                  children: [
                                                                                    /// 4-qavat
                                                                                    data.results[index].subcategories[index2].subcategories[index3].subcategories.isNotEmpty
                                                                                        ? Padding(
                                                                                            padding: const EdgeInsets.only(left: 15),
                                                                                            child: ListView.builder(
                                                                                              /// 4-qavat
                                                                                              itemCount: data.results[index].subcategories[index2].subcategories[index3].subcategories.length,
                                                                                              shrinkWrap: true,
                                                                                              physics: const NeverScrollableScrollPhysics(),
                                                                                              itemBuilder: (context, index4) {
                                                                                                return ExpansionTile(title: Text(data.results[index].subcategories[index2].subcategories[index3].subcategories[index].name));
                                                                                              },
                                                                                            ),
                                                                                          )
                                                                                        : Padding(
                                                                                            padding: const EdgeInsets.only(left: 20),
                                                                                            child: ListTile(
                                                                                                onTap: () {
                                                                                                  getAction(
                                                                                                    categoryId: data.results[index].subcategories[index2].subcategories[index3].id.toString(),
                                                                                                    parentId: data.results[index].subcategories[index2].subcategories[index3].parent.toString(),
                                                                                                    categoryName: data.results[index].subcategories[index2].subcategories[index3].name.toString(),
                                                                                                  );
                                                                                                },
                                                                                                title: Text(data.results[index].subcategories[index2].subcategories[index3].name)))
                                                                                  ],
                                                                                )
                                                                              : Padding(
                                                                                  padding: const EdgeInsets.only(left: 20),
                                                                                  child: ListTile(
                                                                                      onTap: () {
                                                                                        getAction(
                                                                                          categoryId: data.results[index].subcategories[index2].id.toString(),
                                                                                          parentId: data.results[index].subcategories[index2].parent.toString(),
                                                                                          categoryName: data.results[index].subcategories[index2].name.toString(),
                                                                                        );
                                                                                      },
                                                                                      title: Text(data.results[index].subcategories[index2].name)));
                                                                        },
                                                                      ),
                                                                    )
                                                                  : Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left: 20),
                                                                      child:
                                                                          ListTile(
                                                                              onTap:
                                                                                  () {
                                                                                getAction(
                                                                                  categoryId: data.results[index].subcategories[index2].id.toString(),
                                                                                  parentId: data.results[index].subcategories[index2].parent.toString(),
                                                                                  categoryName: data.results[index].subcategories[index2].name.toString(),
                                                                                );
                                                                              },
                                                                              title: Text(data
                                                                                  .results[index]
                                                                                  .subcategories[index2]
                                                                                  .name)))
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: ListTile(
                                                        onTap: () {
                                                          getAction(
                                                            categoryId: data
                                                                .results[index]
                                                                .subcategories[
                                                                    index2]
                                                                .id
                                                                .toString(),
                                                            parentId: data
                                                                .results[index]
                                                                .subcategories[
                                                                    index2]
                                                                .parent
                                                                .toString(),
                                                            categoryName: data
                                                                .results[index]
                                                                .subcategories[
                                                                    index2]
                                                                .name
                                                                .toString(),
                                                          );
                                                        },
                                                        leading: Text(
                                                            data
                                                                .results[index]
                                                                .subcategories[
                                                                    index2]
                                                                .name,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            )),
                                                      ),
                                                    );
                                            },
                                          )
                                        : ListTile(
                                            leading: Text(
                                                data.results[index].name,
                                                style: const TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontSize: 17.0,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onTap: () {
                                              getAction(
                                                categoryId: data
                                                    .results[index].id
                                                    .toString(),
                                                parentId: data
                                                    .results[index].parent
                                                    .toString(),
                                                categoryName: data
                                                    .results[index].name
                                                    .toString(),
                                              );
                                            },
                                          ),
                                  ],
                                )
                              : ListTile(
                                  onTap: () {
                                    getAction(
                                      categoryId:
                                          data.results[index].id.toString(),
                                      parentId:
                                          data.results[index].parent.toString(),
                                      categoryName:
                                          data.results[index].name.toString(),
                                    );
                                  },
                                  leading: Text(data.results[index].name,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold)),
                                ),
                        ]);
                      },
                    )
                  ])));
            }, error: (error, errorText) {
              return const LoadingShimmerList();
            }, loading: () {
              return const LoadingShimmerList();
            }));
          },
        ));
  }


  void getAction(
      {required String categoryId,
      required String parentId,
      required String categoryName}) {

    box.delete("categoryId");
    box.delete("parentId");
    box.put("categoryId", categoryId);
    box.put("parentId", parentId);

    pushNewScreen(context, screen: CategoryPageOpen(
      categoryId: categoryId,
      parentId: parentId,
      categoryName: categoryName,
    ),
    withNavBar: false
    );

  }
}
