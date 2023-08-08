import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_main_1_page/new_collection/new_collection_model.dart';
import 'package:shopping/data/network/internet_main_1_page/internet_new_collections/new_collections.dart';

final apiProviderNewCollection = Provider<InternetMainNewCollectionsBody>(
    (ref) => InternetMainNewCollectionsBody());

final getDataNewCollection = FutureProvider<ModelMainNewCollections>((ref) {
  return ref.read(apiProviderNewCollection).getMainNewCollections();
});
