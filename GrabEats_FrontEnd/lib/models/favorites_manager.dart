import 'package:flutter/foundation.dart';

class FavoritesManager {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  // Using ValueNotifier so UI can react when favorites change
  final ValueNotifier<Set<String>> favoritesNotifier = ValueNotifier<Set<String>>({'Appetite Resto Cafe', 'The Golden Plate'});

  void toggleFavorite(String restaurantName) {
    // Create a new set to trigger ValueNotifier listeners properly
    final newSet = Set<String>.from(favoritesNotifier.value);
    if (newSet.contains(restaurantName)) {
      newSet.remove(restaurantName);
    } else {
      newSet.add(restaurantName);
    }
    favoritesNotifier.value = newSet;
  }

  bool isFavorite(String restaurantName) {
    return favoritesNotifier.value.contains(restaurantName);
  }
}
