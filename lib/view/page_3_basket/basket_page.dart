import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("basket".tr(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(3),
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 0.41,
                            blurRadius: 2)
                      ]),
                  child: Row(
                    children: [
                     const Image(
                        image: AssetImage("assets/images/shopping1.png"),
                        height: 80,
                        fit: BoxFit.cover,
                      ), 
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [


                          Text("Title text", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          SizedBox(
                            height: 30,
                            child: RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              wrapAlignment: WrapAlignment.start,
                              itemPadding: const EdgeInsets.symmetric(
                                  horizontal: 1.0),
                              itemSize: 16,
                              itemBuilder: (context, _) =>
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 10,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: Text("Product haqida qisqacha ma'lumot", style: TextStyle(fontSize: 15),)),
                        ],),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Icon(Icons.delete, color: Colors.red.shade700),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
