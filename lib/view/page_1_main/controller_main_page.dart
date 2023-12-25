import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/model_main_carusel.dart';
import 'package:shopping/data/network/internet_main_1_page/internet_carusel.dart';

final apiProviderHeader =
    Provider<InternetMainCarousel>((ref) => InternetMainCarousel());

final getDataCarousel = FutureProvider<ModelMainPageCarusel>((ref) {
  return ref.read(apiProviderHeader).getCarouselData();
});
