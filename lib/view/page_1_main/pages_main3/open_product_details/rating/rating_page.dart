// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/rating/controller_rating.dart';

class RatingPage extends StatefulWidget {
  String productName;
  String productId;

  RatingPage({super.key, required this.productName, required this.productId});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {

  var box = Hive.box("online");
  double ratingVal = 0;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
            margin: const EdgeInsets.all(10),
            child: Consumer(

              builder: (context, ref, child) =>
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.productName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            "rating".tr(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(width: 12),
                          RatingBar.builder(
                            itemSize: 35,
                            initialRating: 1,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                            const EdgeInsets.symmetric(horizontal: 0.0),
                            itemBuilder: (context, _) =>
                            const Icon(
                              Icons.star,
                              color: Color(0xffFD7E14),
                            ),
                            onRatingUpdate: (rating) {
                              ratingVal = rating;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.17,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade200,
                        ),
                        child: SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.95,
                          child: TextFormField(
                            controller: textEditingController,
                            onTapOutside: (PointerDownEvent event) {
                              FocusScope.of(context).unfocus();
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              border: InputBorder.none,
                              counter: SizedBox.shrink(),
                            ),
                            maxLines: null,
                            expands:  true,
                            maxLength: 999,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: MaterialButton(
                          onPressed: () {
                            ref.read(ratingNotifier.notifier).sendServerRating(
                                rating: ratingVal.toString(),
                                comment: textEditingController.text.toString(),
                                product: widget.productId,
                                client: box.get("token"));
                          },
                          minWidth: double.infinity,
                          height: 50,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Text("send".tr()),
                        ),
                      ),
                    ],
                  ),
            )));
  }
}
