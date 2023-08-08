import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping/view/page_1_main/pages_main3/search_page/controller_search_page.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class MainSearchPage extends StatefulWidget {
  const MainSearchPage({super.key});

  @override
  State<MainSearchPage> createState() => _MainSearchPageState();
}

class _MainSearchPageState extends State<MainSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Center(
        //     child: Padding(
        //   padding: const EdgeInsets.only(left: 8),
        //   child: Icon(Icons.search, color: Colors.grey),
        //   // Text("search".tr(),
        //   //     style:
        //   //         TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        // )),
        iconTheme: IconThemeData(color: Colors.black),

        title:Text("search".tr(), style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          // hintText: "search".tr(),
                          // prefix: Text("search".tr(), style: TextStyle(color: Colors.grey)),

                          border: OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey))),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Consumer(
                    builder: (context, ref, child) {
                      final dataBrand = ref.watch(getMainSearchBrandData);

                      return dataBrand.when(data: (data) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("brand".tr(),
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.results.length,
                                itemBuilder: (context, index) => Container(
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      children: [
                                        Center(
                                            child: Text(
                                          data.results[index].name.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                        )),
                                      ],
                                    )),
                              ),
                            ),
                            const SizedBox(height: 20),

                          ],
                        );
                      }, error: (error, errorText) {
                        return Text(errorText.toString());
                      }, loading: () {
                        return const LoadingShimmerListHorizontal();
                      });
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                              baseColor: Colors.grey.shade50,
                              highlightColor: Colors.grey.shade200,
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ));
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
