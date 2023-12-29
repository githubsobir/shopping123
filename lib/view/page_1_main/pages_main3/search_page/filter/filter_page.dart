import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/model_search.dart';
import 'package:shopping/view/page_1_main/pages_main3/search_page/controller_search_page.dart';
import 'package:shopping/view/page_1_main/pages_main3/search_page/filter/filter_controller.dart';

class Filter extends ConsumerStatefulWidget {
  static String routeName = "/search_screen";

  Filter({Key? key}) : super(key: key);

  @override
  ConsumerState<Filter> createState() => _FilterState();
}

class _FilterState extends ConsumerState<Filter> {
  List<String> regions = [
    "Toshkent viloyati",
    "Toshkent shahri",
    "Surxondaryo viloyati",
    "Sirdaryo viloyati",
    "Samarqand viloyati",
    "Qoraqalpogʻiston Respublikasi",
    "Qashqadaryo viloyati",
    "Navoiy viloyati",
    "Namangan viloyati",
    "Xorazm viloyati",
    "Jizzax viloyati",
    "Fargʻona viloyati",
    "Buxoro viloyati",
    "Andijon viloyati",
  ];

  late ModelSearch modelSearch;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "filter".tr(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ],
            ),
            const Divider(),
            MaterialButton(
              color: Colors.red.shade500,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {
                Navigator.of(context).pop();

                modelSearch = ModelSearch(
                  search:     ref.watch(textSearch),
                    color: ref.watch(selectColorQueryProvider),
                    brand: ref.watch(selectedBrandIdProvider),
                    minPrice: ref.watch(startValueProvider),
                    maxPrice: ref.read(endValueProvider),
                    size: ref.watch(selectSizeIndexProvider));

                ref.read(cont.notifier).getListFromInternet(modelSearch: modelSearch);

              },
              child: Text("search".tr(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 5),
            Text(
              "category".tr(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 5),
            buildCategories(),
            const Divider(),
            const SizedBox(height: 5),
            Text(
              "chooseColor".tr(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            setColor(),
            const Divider(),
            const SizedBox(height: 5),
            Text(
              "chooseSize".tr(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            setSize(),
            const Divider(),
            const SizedBox(height: 5),
            buildQuantityField(),
          ],
        ),
      ),
    );
  }

  // Container selectRegion(BuildContext context) {
  //   return Container(
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.black87),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: MaterialButton(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           ref.watch(selectRegionProvider) == ""
  //               ? const Text("Hududni tanlansh")
  //               : Text(ref.watch(selectRegionProvider)),
  //           const Spacer(),
  //           const Icon(Icons.chevron_right_sharp)
  //         ],
  //       ),
  //       onPressed: () async {
  //         // var item = await showTextListPicker(
  //         //     context: context,
  //         //
  //         //     selectedItem: ref.watch(selectRegionProvider,
  //         //
  //         //     ),
  //         //     findFn: (str) async => regions);
  //         // if (item != null) {
  //         //   ref.read(selectRegionProvider.notifier).state = item;
  //         // }
  //       },
  //     ),
  //   );
  // }

  Widget buildQuantityField() {
    // 1
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 2
        Text(
          "moneyFilter".tr(),
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ("\$${ref.watch(startValueProvider).toInt()}") +
                  ("-") +
                  ("\$${ref.watch(endValueProvider).toInt()}"),
              style: const TextStyle(
                color: Color(0xff3E3E59),
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20, child: RangeSliderExample()),
      ],
    );
  }

  Widget buildCategories() {
    return SizedBox(
        height: 35,
        // getBrands
        child: Consumer(
            builder: (context, ref, child) =>
                ref.watch(getBrands).when(data: (data) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.results.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            ref.read(selectedBrandProvider.notifier).state =
                                index;

                            ref.read(selectedBrandIdProvider.notifier).state =
                                data.results[index].id.toString();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 2, right: 2),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade300,
                              border:
                                  ref.watch(selectedBrandProvider).toString() ==
                                          index.toString()
                                      ? Border.all(
                                          color: Colors.black,
                                          width: 2,
                                        )
                                      : const Border(),
                            ),
                            // : BoxDecoration(
                            //     color: Colors.grey.shade200,
                            //     borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              data.results[index].name,
                              style: TextStyle(
                                  decorationThickness: 1.5,
                                  color: ref
                                              .watch(selectedBrandProvider)
                                              .toString() ==
                                          index.toString()
                                      ? Colors.black
                                      : Colors.black87,
                                  // decoration: ref.watch(selectedSubCategProvider) == index
                                  //     ? TextDecoration.underline
                                  //     : TextDecoration.none,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        );
                      });
                }, error: (error, errorText) {
                  return Text(errorText.toString());
                }, loading: () {
                  return Text("loading");
                })));
  }

  SizedBox setColor() {
    return SizedBox(
      height: 120,
      child: Consumer(
          builder: (context, ref, child) =>
              ref.watch(getColor).when(data: (data) {
                return GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 0,
                      mainAxisExtent: 50,
                      crossAxisSpacing: 0,
                      childAspectRatio: 0.7,
                      crossAxisCount: 3),
                  itemCount: data.results.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          ref.read(selectColorIndexProvider.notifier).state =
                              index;

                          ref.read(selectColorQueryProvider.notifier).state =
                              data.results[index].code.toString();
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            border: ref.watch(selectColorIndexProvider) == index
                                ? Border.all(
                                    width: 2,
                                    color: Colors.black,
                                  )
                                : const Border(),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Stack(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Color(int.parse(
                                                data.results[index].code
                                                    .substring(1, 7),
                                                radix: 16) +
                                            0xFF000000),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }, error: (error, errorText) {
                return Text(errorText.toString());
              }, loading: () {
                return Text("Loading...");
              })),
    );
  }

  SizedBox setSize() {
    return SizedBox(
        height: 150,
        child: ref.watch(getSize).when(
            data: (data) => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 4,
                    childAspectRatio: 0.8,
                    crossAxisCount: 4,
                  ),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: data.results.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        ref.read(selectSizeIndexProvider.notifier).state =
                            index;
                      },
                      child: Container(
                        margin: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: ref.watch(selectSizeIndexProvider) == index
                              ? Border.all(
                                  width: 2,
                                  color: Colors.black,
                                )
                              : Border.all(
                                  width: 2,
                                  color: const Color(0xffCBCBCB),
                                ),
                          // borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child:
                                Center(child: Text(data.results[index].name)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
            error: (e, eText) {
              return Text(eText.toString());
            },
            loading: () {
              return Text("loading");
            }));
  }
}

class RangeSliderExample extends StatefulWidget {
  const RangeSliderExample({super.key});

  @override
  State<RangeSliderExample> createState() => _RangeSliderExampleState();
}

class _RangeSliderExampleState extends State<RangeSliderExample> {
  RangeValues _currentRangeValues = const RangeValues(1, 10000);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => RangeSlider(
        // values: _currentRangeValues,
        values: RangeValues(
            ref.watch(startValueProvider), ref.watch(endValueProvider)),
        max: 10000,
        min: 1,
        divisions: 500,
        activeColor: const Color(0xff121212),
        inactiveColor: const Color(0xffCBCBCB),
        // labels: RangeLabels(
        //   _currentRangeValues.start.round().toString(),
        //   _currentRangeValues.end.round().toString(),
        // ),
        onChanged: (RangeValues values) {
          // _currentRangeValues = values;
          ref.read(startValueProvider.notifier).state = values.start;
          ref.read(endValueProvider.notifier).state = values.end;
        },
      ),
    );
  }
}
