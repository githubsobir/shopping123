import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/new_collections.dart';

// ishlatilinmagan
Widget mainBody({required BuildContext context, required WidgetRef ref}) {
  return const NewCollection();

  //   Scaffold(
  //   body: Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: ContainedTabBarView(
  //       tabBarProperties: TabBarProperties(
  //         padding: const EdgeInsets.symmetric(horizontal: 10),
  //         margin: const EdgeInsets.only(bottom: 5, top: 5),
  //         indicator: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10),
  //           border: Border.all(color: const Color(0xff121212)),
  //         ),
  //         indicatorPadding: const EdgeInsets.symmetric(horizontal: 6),
  //         labelStyle: const TextStyle(
  //             color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
  //         labelColor: Colors.black,
  //         indicatorColor: Colors.red,
  //         height: 35,
  //       ),
  //       tabs: const [
  //         Text('New Arrivals'),
  //         Text('Best Sellers'),
  //         Text('Sale'),
  //       ],
  //       views: const [NewCollection(), BestSellers(), Sales()],
  //       onChange: (index) {
  //         if(index == 1){
  //           // ref.read(getDataInfinitiList("1"));
  //         }
  //         // setState((){});
  //       },
  //     ),
  //   ),
  //
  //   // const TabBarView(
  //   //   children: [
  //   //
  //   //   ],
  //   // ),
  // );
}
