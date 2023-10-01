import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/view/page_1_main/pages_main3/new_collection/controller_new_collection.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/controller_details.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/mini_details/controller_mini_details.dart';

class MiniDetails extends ConsumerStatefulWidget {
  String idProduct;
  bool isFavourite;

  MiniDetails({super.key, required this.idProduct, required this.isFavourite});

  @override
  ConsumerState<MiniDetails> createState() => _MiniDetailsState();
}

class _MiniDetailsState extends ConsumerState<MiniDetails> {
  getActionCheck() {
    if (ref.read(selectSizeMiniDetails) > -1 &&
        ref.read(selectColorMiniDetails) > -1) {
      ref.read(setFavourite2.notifier).setOrder(
          idOrder: widget.idProduct.toString(),
          count: ref.read(countMiniDetails).toString(),
          sizeProduct: ref.read(sizeSelectProduct).toString(),
          colorProduct: ref.read(colorSelectProduct).toString()
      );

      ref.read(sendServer.notifier).setCartWithProductId(
          idProduct: widget.idProduct,
          colorProduct: ref.read(colorSelectProduct),
          countProduct: ref.read(countMiniDetails).toString(),
          sizeProduct: ref.read(sizeSelectProduct));

      Navigator.of(context).pop();
    } else {
      if (ref.read(selectSizeMiniDetails) == -1) {
        ref.read(noSelectSizeMiniDetails.notifier).state = 1;
      }

      if (ref.read(selectColorMiniDetails) == -1) {
        ref.read(noSelectColorMiniDetails.notifier).state = 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final getDetail = ref.watch(getDetails(widget.idProduct));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: SafeArea(
            child: getDetail.when(data: (data) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 3,
                                blurRadius: 3),
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: data.variables.isNotEmpty
                            ? data.variables[0].media.isNotEmpty
                                ? Image.network(
                                    data.variables[0].media[0].file,
                                    height: 100,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                          "assets/images/shopping.png");
                                    },
                                  )
                                : const SizedBox.shrink()
                            : const SizedBox.shrink(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          data.name.toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ref.watch(noSelectColorMiniDetails) == 0
                        ? Colors.white
                        : Colors.red.shade100,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("chooseColor".tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 45,
                          // width: MediaQuery.of(context).size.width,

                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: ref.read(getListDetails).length,
                            itemBuilder: (context, index) {
                              return ref
                                          .read(getListDetails)[index]
                                          .color
                                          .toString()
                                          .length >
                                      5
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          /// Color
                                          ref
                                                  .read(colorSelectProduct.notifier)
                                                  .state =
                                              ref
                                                  .read(getListDetails)[index]
                                                  .color
                                                  .toString();

                                          ref
                                              .read(selectColorMiniDetails
                                                  .notifier)
                                              .state = index;
                                          ref
                                              .read(noSelectColorMiniDetails
                                                  .notifier)
                                              .state = 0;
                                        },
                                        child: Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: ref.watch(
                                                        selectColorMiniDetails) ==
                                                    index
                                                ? Border.all(
                                                    width: 3,
                                                    color: Colors.red,
                                                  )
                                                : Border.all(
                                                    width: 1,
                                                    color: Colors.grey,
                                                  ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: Color(int.parse(
                                                        ref
                                                            .read(getListDetails)[
                                                                index]
                                                            .color
                                                            .substring(1, 7),
                                                        radix: 16) +
                                                    0xFF000000),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                            ),

                  ),
                  ),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ref.watch(noSelectSizeMiniDetails) == 0
                        ? Colors.white
                        : Colors.red.shade100,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("chooseSize".tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 45,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ref.read(getListDetails).length,
                          itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    /// size
                                    ref.read(sizeSelectProduct.notifier).state =
                                        ref
                                            .read(getListDetails)[index]
                                            .size
                                            .toString();

                                    /// select size
                                    ref
                                        .read(selectSizeMiniDetails.notifier)
                                        .state = index;
                                    ref
                                        .read(noSelectSizeMiniDetails.notifier)
                                        .state = 0;
                                  },
                                  child: Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                      border: ref.watch(
                                                  selectSizeMiniDetails) ==
                                              index
                                          ? Border.all(
                                              width: 3,
                                              color: Colors.red,
                                            )
                                          : Border.all(
                                              width: 1,
                                              color: const Color(0xffCBCBCB),
                                            ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Center(
                                            child: Text(
                                          ref
                                              .read(getListDetails)[index]
                                              .size
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (ref.watch(countMiniDetails.notifier).state >
                                    1) {
                                  ref.watch(countMiniDetails.notifier).state--;
                                }
                              },
                              icon: const Icon(Icons.remove)),
                          const SizedBox(width: 10),
                          Text(ref.watch(countMiniDetails).toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 10),
                          IconButton(
                              onPressed: () {
                                ref.watch(countMiniDetails.notifier).state++;
                              },
                              icon: const Icon(Icons.add)),
                        ],
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: Colors.red,
                        onPressed: getActionCheck,
                        height: 40,
                        textColor: Colors.white,
                        child: Text("addCart".tr()),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }, error: (error, errorText) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppBar(
                backgroundColor: Colors.white,
                iconTheme: const IconThemeData(color: Colors.black),
                elevation: 0,
              ),
              Image.asset(
                "assets/images/shopping1.png",
                fit: BoxFit.cover,
              ),
              const Text("Ma'lumot olishda xatolik"),
              const Text(""),
            ],
          ));
        }, loading: () {
          return const Center(
            child: Text("Loading..."),
          );
        })),
      ),
    );
  }
}
