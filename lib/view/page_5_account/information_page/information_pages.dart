import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/view/page_5_account/information_page/controller_information.dart';
import 'package:shopping/widgets/loading_pagea/loading_cupertino.dart';

class InformationPages extends StatefulWidget {
  const InformationPages({super.key});

  @override
  State<InformationPages> createState() => _InformationPagesState();
}

class _InformationPagesState extends State<InformationPages> {
  int selected = -1;
 //attention
  int selected2 = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title:  Text("information".tr(),
              style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            return SafeArea(
                child: ref.watch(getAccountInfo).when(data: (data) {
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
                                return Column(children: <Widget>[
                                  const Divider(
                                    height: 17.0,
                                    color: Colors.white,
                                  ),
                                  data.results[index].answer.isNotEmpty
                                      ? ExpansionTile(
                                    key: Key(index.toString()),
                                    //attention
                                    trailing:index == selected ? Icon(Icons.remove):Icon(Icons.add),
                                    initiallyExpanded: index == selected,

                                    title: Text(data.results[index].answer.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w500)),
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
                                Padding(
                                  padding: const EdgeInsets.only(right: 15, left: 15, top: 8, bottom: 5),
                                  child: Text(
                                           data.results[index].question.toString(),
                                           style:  TextStyle(
                                               color: Colors.blue.shade800,
                                               fontSize: 17.0,
                                               fontWeight:
                                               FontWeight.bold)),
                                ),
                                     // SizedBox(
                                     //
                                     //   child: ListTile(
                                     //      leading: Text(
                                     //          data.results[index].question.toString(),
                                     //          style: const TextStyle(
                                     //              color: Colors.blueAccent,
                                     //              fontSize: 17.0,
                                     //              fontWeight:
                                     //              FontWeight.bold)),
                                     //      onTap: () {
                                     //        // getAction(
                                     //        //   categoryId: data
                                     //        //       .results[index].id
                                     //        //       .toString(),
                                     //        //   parentId: data
                                     //        //       .results[index].parent
                                     //        //       .toString(),
                                     //        //   categoryName: data
                                     //        //       .results[index].name
                                     //        //       .toString(),
                                     //        // );
                                     //      },
                                     //    ),
                                     //   height: 250,
                                     // ),
                                    ],
                                  )
                                      : ListTile(
                                    onTap: () {
                                      // getAction(
                                      //   categoryId:
                                      //   data.results[index].id.toString(),
                                      //   parentId:
                                      //   data.results[index].parent.toString(),
                                      //   categoryName:
                                      //   data.results[index].name.toString(),
                                      // );
                                    },
                                    leading: Text(data.results[index].question,
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


}
