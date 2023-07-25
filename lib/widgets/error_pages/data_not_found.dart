// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DataNotFound extends StatelessWidget {
  String errorText;

  DataNotFound({Key? key, required this.errorText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(errorText.toString())),
    );
  }
}
