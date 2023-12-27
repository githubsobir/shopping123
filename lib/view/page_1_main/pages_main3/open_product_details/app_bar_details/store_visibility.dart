import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/open_store_products/open_store_all_product.dart';
import 'package:url_launcher/url_launcher.dart';


final visibilityController = StateProvider<bool>((ref) => false);

Widget visibilityStore({
  required BuildContext context,
  required String categoryId,
  required String parentId,
  required String categoryName,
  required String organization,
  required bool boolVisibility
}) {
  return Consumer(builder: (context, ref, child) =>  Visibility(
    visible:boolVisibility,
    child: SizedBox(
    height: 120,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: Colors.grey.shade50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("seller".tr()),
                      const Icon(
                        Icons.person_outline,
                        size: 24,
                        color: Colors.black,
                      ),
                      // Text(
                      //   "seller".tr(),
                      //   style:const TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 18,
                      //       fontWeight: FontWeight.w500),
                      // ),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          organization,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 45,
                    child: MaterialButton(
                      padding: const EdgeInsets.only(left: 0),
                      onPressed: () {
                        pushNewScreen(context,
                            screen: OpenStoreAllProduct(
                              categoryId: categoryId,
                              categoryName: categoryName,
                              organization: organization,
                              parentId: parentId,
                            ));
                      },
                      child: Column(
                        children: [
                          const Icon(LineIcons.alternateStore),
                          Text(
                            "store".tr(),
                            maxLines: 2,
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 1),
                  const SizedBox(width: 1),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: () {
                        launchUrl(Uri(scheme: "tel", path: "+998901234567"));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            LineIcons.alternatePhone,
                            color: Colors.white,
                          ),
                          Text(
                            "callNow".tr(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ),)
  );
}
