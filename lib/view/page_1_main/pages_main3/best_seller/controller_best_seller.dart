import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';
import 'package:shopping/data/model/model_main_1_page/model_main_product_details.dart';
import 'package:shopping/data/model/model_main_1_page/test_model_infinite_lIst.dart';
import 'package:shopping/data/network/internet_main_1_page/test_infinitelist.dart';

class CustomExampleState extends PagedState<String, ProductModel> {
  // We can extends [PagedState] to add custom parameters to our state
  final bool filterByCity;

  const CustomExampleState(
      {this.filterByCity = false,
      List<ProductModel>? records,
      String? error,
      String? nextPageKey,
      List<String>? previousPageKeys})
      : super(records: records, error: error, nextPageKey: nextPageKey);

  // We can customize our .copyWith for example
  @override
  CustomExampleState copyWith(
      {bool? filterByCity,
      List<ProductModel>? records,
      dynamic error,
      dynamic nextPageKey,
      List<String>? previousPageKeys}) {
    final sup = super.copyWith(
        records: records,
        error: error,
        nextPageKey: nextPageKey,
        previousPageKeys: previousPageKeys);
    return CustomExampleState(
        filterByCity: filterByCity ?? this.filterByCity,
        records: sup.records,
        error: sup.error,
        nextPageKey: sup.nextPageKey,
        previousPageKeys: sup.previousPageKeys);
  }
}

class CustomExampleNotifier extends StateNotifier<CustomExampleState>
    with PagedNotifierMixin<String, ProductModel, CustomExampleState> {
  CustomExampleNotifier() : super(const CustomExampleState());

  @override
  Future<List<ProductModel>?> load(String page, int limit) async {
    try {
      if (state.previousPageKeys.contains(page)) {
        await Future.delayed(const Duration(seconds: 0), () {
          state = state.copyWith();
        });
        return state.records;
      }
      var users = await Future.delayed(const Duration(milliseconds: 400), () {
        // This simulates a network call to an api that returns paginated users
        return List.generate(
            20,
            (index) => ProductModel(
                  id: "${page}_$index",
                  title: "Produkt nomi",
                  price: "109000",
                  description: "Product haqida qisqacha",
                  category: "4",
                  image:
                      "https://m.media-amazon.com/images/I/51c7PrN5AFL._AC_UL1000_.jpg",
                  rating: "4",
                ));
      });
      // we then update state accordingly
      state = state.copyWith(
          records: [...(state.records ?? []), ...users],
          nextPageKey: users.length < limit ? null : users[users.length - 1].id,
          previousPageKeys: {...state.previousPageKeys, page}.toList());
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
    return null;
  }

  // Super simple example of custom methods of the StateNotifier
  void add(ProductModel user) {
    state = state.copyWith(records: [...(state.records ?? []), user]);
  }

  void delete(ProductModel user) {
    state = state.copyWith(records: [...(state.records ?? [])]..remove(user));
  }
}

final customExampleProvider =
    StateNotifierProvider<CustomExampleNotifier, CustomExampleState>(
        (_) => CustomExampleNotifier());

///
///
///
///

final customExampleProvider2 =
StateNotifierProvider<CustomExampleNotifier, CustomExampleState>(
        (_) => CustomExampleNotifier());
