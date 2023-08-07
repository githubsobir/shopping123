import 'package:flutter/material.dart';

class NewCollection extends StatefulWidget {
  const NewCollection({super.key});

  @override
  State<NewCollection> createState() => _NewCollectionState();
}

class _NewCollectionState extends State<NewCollection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("NewCollection"),),);
  }
}
