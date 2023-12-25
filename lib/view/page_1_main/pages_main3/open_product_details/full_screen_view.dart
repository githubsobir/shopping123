// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shopping/view/page_1_main/pages_main3/open_product_details/main_product_details.dart';

class FullScreenView extends StatefulWidget {
  List<ModelSelectItem> imagesList;
  String pructName;

  FullScreenView({Key? key, required this.imagesList, required this.pructName})
      : super(key: key);

  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  final PageController _controller = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.pructName.toString(),
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: size.height * 0.65,
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                controller: _controller,
                children: images(),
              ),
            ),
            SizedBox(
              height: size.height * 0.15,
              child: imageView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageView() {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              ("${index + 1}") + ("/") + (widget.imagesList.length.toString()),
              style: const TextStyle(fontSize: 14, letterSpacing: 8),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.imagesList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onDoubleTap: () {
                  getShowFull();
                },
                onTap: () {
                  _controller.jumpToPage(index);
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      widget.imagesList[index].image,
                      alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> images() {
    return List.generate(
      widget.imagesList.length,
      (index) {
        return InteractiveViewer(
          transformationController: TransformationController(),
          child: GestureDetector(
            onDoubleTap: () {
              getShowFull();
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/gerb.jpg"))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: InteractiveViewer(
                  panEnabled: false,
                  // Set it to false
                  boundaryMargin: EdgeInsets.all(20),
                  minScale: 0.5,
                  maxScale: 4,
                  child: Image.network(
                    fit: BoxFit.cover,
                    widget.imagesList[index].image,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  getShowFull() {
    showDialog(
      context: context,
      useSafeArea: true,
      builder: (context) => Container(
        margin: const EdgeInsets.all(1),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.only(right: 12),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: const Icon(Icons.cancel, color: Colors.red),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                child: InteractiveViewer(
                  transformationController: TransformationController(),
                  panEnabled: true,
                  boundaryMargin: const EdgeInsets.all(1),
                  minScale: 0.5,
                  maxScale: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      fit: BoxFit.cover,
                      widget.imagesList[index].image,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
