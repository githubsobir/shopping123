import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_5_account/model_account_info.dart';
import 'package:shopping/data/network/internet_5_account/internet_account_info.dart';

final apiAccountInfo =
    Provider<InternetAccountInformation>((ref) => InternetAccountInformation());

final getAccountInfo = FutureProvider.autoDispose<ModelAccountInformation>((ref) {

  return ref.read(apiAccountInfo).getInformation();
});
