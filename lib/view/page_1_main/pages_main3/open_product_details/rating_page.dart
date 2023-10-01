// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class RatingPage extends StatefulWidget {
  String productName;

  RatingPage({super.key, required this.productName});

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Text(widget.productName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: 15),
            Row(
              children: [
                 Text("rating".tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                const SizedBox(width: 12),
                RatingBar.builder(
                  itemSize: 35,
                  initialRating: 1,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Color(0xffFD7E14),
                  ),
                  onRatingUpdate: (rating) {},
                ),


              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height*0.17,

              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey.shade200,),
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.95,
                child: TextFormField(
                  onTapOutside: (PointerDownEvent event){
                    FocusScope.of(context).unfocus();
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: InputBorder.none,
                  ),
                  maxLines: 6,
                  maxLength: 200,

                ),
              ),
            ),
            const SizedBox(height: 20,),
            MaterialButton(onPressed: (){},
            minWidth: double.infinity,
              height: 50,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Text("send".tr()),
            ),
            const SizedBox(height: 10,),


          ],
        ),
      ),
    );
  }
}
