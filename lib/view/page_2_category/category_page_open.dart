// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CategoryPageOpen extends StatefulWidget {
  String categoryId;
  String parentId;
  String categoryName;

  CategoryPageOpen(
      {Key? key,
      required this.categoryId,
      required this.parentId,
      required this.categoryName})
      : super(key: key);

  @override
  _CategoryPageOpenState createState() => _CategoryPageOpenState();
}

class _CategoryPageOpenState extends State<CategoryPageOpen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName, style: const TextStyle(color: Colors.black)),
      backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("parentId ->  ${widget.parentId}"),
          Text("categoryId ->  ${widget.categoryId}"),
          Text("categoryName ->  ${widget.categoryName}"),
        ],
      )),
    );
  }
}
