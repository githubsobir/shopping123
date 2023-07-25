import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/model_main_carusel.dart';
import 'package:shopping/data/network/internet_main_1_page/internet_carusel.dart';

final apiProvider =
Provider<InternetMainCarousel>((ref) => InternetMainCarousel());

final getDataCarousel = FutureProvider<ModelMainPageCarusel>((ref) {
  log(ref.read(apiProvider).getCarouselData().toString());
  return ref.read(apiProvider).getCarouselData();
});


// final getDataBody = FutureProvider((ref) => )

final myColorsCategory = StateProvider.family<List<Color>, int>((ref,
    index) {
  List<Color> myColors = [];
  for (int i = 0; i < 8; i ++) {

    if(index != i){
      myColors.add(Colors.white);
    }else{
      myColors.add(Colors.red);
    }
  }
  return myColors;
}
);
