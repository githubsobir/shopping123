import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedSubCategProvider = StateProvider<int>((ref) {
  return 0;
});
final selectRegionProvider = StateProvider<String>((ref) {
  return '';
});
final selectColorIndexProvider = StateProvider<int>((ref) {
  return 0;
});
final selectSizeIndexProvider = StateProvider<int>((ref) {
  return 0;
});
final startValueProvider = StateProvider<double>((ref) {
  return 250.0;
});
final endValueProvider = StateProvider<double>((ref) {
  return 700.0;
});