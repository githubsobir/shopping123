import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/view/page_1_main/pages_main3/search_page/filter/filter_page.dart';

class Filter extends ConsumerStatefulWidget {
  static String routeName = "/search_screen";

  Filter({Key? key}) : super(key: key);

  @override
  ConsumerState<Filter> createState() => _FilterState();
}

class _FilterState extends ConsumerState<Filter> {
  List<String> subCateg = [
    "Pyjama",
    "Dresses",
    "Outdoor",
    "Pyjama",
    "Dresses",
    "Outdoor",
  ];

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

  List<Color> colors = [
    const Color(0xff20C997),
    const Color(0xffAF83F8),
    const Color(0xffE25563),
    const Color(0xff121212),
    const Color.fromRGBO(250, 250, 250, 3),
  ];
  List<String> sizes = [
    "S",
    "M",
    "L",
    "XL",
    "2XL",
    "",
  ];

  @override
  void dispose() {
    // Future.delayed(Duration(milliseconds: 100)).then((value) => ref.read(selectedSubCategProvider.notifier).state = 0);

    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return SafeArea(
    child: Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Filterlar",
                  style: TextStyle(
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
            const SizedBox(height: 20),
            Text(
              "Categories".toUpperCase(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            // const Text(
            //   "<Ayollar kiyimlari",
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold),
            //   textAlign: TextAlign.start,
            // ),
            const SizedBox(height: 10),
            buildCategories(),
            const SizedBox(height: 20),
            Text(
              "Regions".toUpperCase(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 10),
            selectRegion(context),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Color".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  setColor(),
                  const SizedBox(height: 20),
                  Text(
                    "Size".toUpperCase(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  setSize(),
                  const SizedBox(height: 50),
                  buildQuantityField(),
                  const Spacer(),
                  const Center(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.black87,
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Container selectRegion(BuildContext context) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black87),
      borderRadius: BorderRadius.circular(8),
    ),
    child: MaterialButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ref.watch(selectRegionProvider) == ""
              ? const Text("Hududni tanlansh")
              : Text(ref.watch(selectRegionProvider)),
          const Spacer(),
          const Icon(Icons.chevron_right_sharp)
        ],
      ),
      onPressed: () async {
        // var item = await showTextListPicker(
        //     context: context,
        //
        //     selectedItem: ref.watch(selectRegionProvider,
        //
        //     ),
        //     findFn: (str) async => regions);
        // if (item != null) {
        //   ref.read(selectRegionProvider.notifier).state = item;
        // }
      },
    ),
  );
}


  Widget buildQuantityField() {
    // 1
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 2
        RangeSlider(
          min: 0.0,
          max: 1000.0,
          activeColor: const Color(0xff121212),
          inactiveColor: const Color(0xffCBCBCB),
          values: RangeValues(
              ref.watch(startValueProvider), ref.watch(endValueProvider)),
          onChanged: (values) {
            ref.read(startValueProvider.notifier).state = values.start;
            ref.read(endValueProvider.notifier).state = values.end;
          },
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ("\$${ref.watch(startValueProvider)}".substring(0, 2)) +
                  ("-") +
                  ("\$${ref.watch(endValueProvider)}".substring(0, 5)),
              style: const TextStyle(
                color: Color(0xff3E3E59),
                fontSize: 18,
              ),
            ),
          ],
        )
      ],
    );
  }
Widget buildCategories() {
  return SizedBox(
    height: 50,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: subCateg.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              ref.read(selectedSubCategProvider.notifier).state = index;
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: ref.watch(selectedSubCategProvider) == index
                    ? BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: ref.watch(selectedSubCategProvider) == index
                      ? Border.all(
                    color: Colors.black,
                    width: 1,
                  )
                      : const Border(),
                )
                    : BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  subCateg[index],
                  style: TextStyle(
                      decorationThickness: 1.5,
                      color: ref.watch(selectedSubCategProvider) == index
                          ? Colors.black
                          : Colors.black87,
                      // decoration: ref.watch(selectedSubCategProvider) == index
                      //     ? TextDecoration.underline
                      //     : TextDecoration.none,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          );
        }),
  );
}

SizedBox setColor() {
  return SizedBox(
    height: 40,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: colors.length - 1,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () {
              ref.read(selectColorIndexProvider.notifier).state = index;
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
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

SizedBox setSize() {
  return SizedBox(
    height: 40,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: sizes.length - 1,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () {
              ref.read(selectSizeIndexProvider.notifier).state = index;
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
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
                  height: 35,
                  width: 35,
                  child: Center(child: Text(sizes[index].toString())),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
}