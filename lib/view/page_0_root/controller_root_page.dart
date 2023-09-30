import 'package:flutter_riverpod/flutter_riverpod.dart';

bool boolValue = false;
final boolHideNavBar = StateProvider<bool>((ref) {
  return boolValue;
});
