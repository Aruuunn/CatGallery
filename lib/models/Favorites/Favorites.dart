import 'package:flutter/material.dart';

class Favorites with ChangeNotifier {
  List<String> _favorites = [];
  Set _s = new Set();

  bool isFavorite(String url) => _s.contains(url);

  List<String> get favorites => _favorites;

  void removeFromFavorites(String url) {
    if (_s.contains(url)) {
      _favorites.remove(url);
      _s.remove(url);
      notifyListeners();
    }
  }

  void addToFavorites(String url) {
    if (!_s.contains(url)) {
      _favorites.add(url);
      _s.add(url);
      notifyListeners();
    }
  }
}
