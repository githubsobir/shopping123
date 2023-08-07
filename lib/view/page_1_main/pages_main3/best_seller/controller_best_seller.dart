import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';

class User {
  final String id;
  final String name;
  final String profilePicture;
  final String summa;
  final String productId;
  final String quantity;
  final String brandId;
  final String categoryId;
  final String gender;

  const User(
      {required this.id,
        required this.name,
        required this.profilePicture,
        required this.summa,
        required this.productId,
        required this.quantity,
        required this.brandId,
        required this.categoryId,
        required this.gender,


      });
}

class CustomExampleState extends PagedState<String, User> {
  // We can extends [PagedState] to add custom parameters to our state
  final bool filterByCity;

  const CustomExampleState(
      {this.filterByCity = false,
      List<User>? records,
      String? error,
      String? nextPageKey,
      List<String>? previousPageKeys})
      : super(records: records, error: error, nextPageKey: nextPageKey);

  // We can customize our .copyWith for example
  @override
  CustomExampleState copyWith(
      {bool? filterByCity,
      List<User>? records,
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
    with PagedNotifierMixin<String, User, CustomExampleState> {
  CustomExampleNotifier() : super(const CustomExampleState());

  @override
  Future<List<User>?> load(String page, int limit) async {
    try {
      //as build can be called many times, ensure
      //we only hit our page API once per page
      if (state.previousPageKeys.contains(page)) {
        await Future.delayed(const Duration(seconds: 0), () {
          state = state.copyWith();
        });
        return state.records;
      }
      var users = await Future.delayed(const Duration(seconds: 1), () {
        // This simulates a network call to an api that returns paginated users
        return List.generate(
            20,
            (index) => User(
                id: "${page}_$index",
                name: "Produkt nomi",
                brandId: "1",
                categoryId: "1",
                gender: "1",
                productId: "1",
                quantity: "1002",
                summa: "1099000",
                profilePicture:
                    "https://m.media-amazon.com/images/I/51c7PrN5AFL._AC_UL1000_.jpg"));
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
  void add(User user) {
    state = state.copyWith(records: [...(state.records ?? []), user]);
  }

  void delete(User user) {
    state = state.copyWith(records: [...(state.records ?? [])]..remove(user));
  }
}

final customExampleProvider =
    StateNotifierProvider<CustomExampleNotifier, CustomExampleState>(
        (_) => CustomExampleNotifier());
