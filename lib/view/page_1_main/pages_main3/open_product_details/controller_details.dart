import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_details/model_details.dart';
import 'package:shopping/data/network/internet_details/internet_details.dart';

final apiProviderDetails =
    Provider<InternetDetailsInformation>((ref) => InternetDetailsInformation());



final getDetails = FutureProvider.family<ModelDetails, String>((ref, id) async{
  return await ref.read(apiProviderDetails).getDetailsInformation(id: id);
});
