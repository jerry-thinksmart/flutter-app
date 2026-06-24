import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CartProvider with ChangeNotifier {
  Map<String, int> _items = {
    "electronics": 1,
    "fashion": 1,
    "home": 3,
  };

  Map<String, int> get items => _items;
  int get cartCount => _items.length;

  void addItem(String productId) {
    if (_items.containsKey(productId)) {
      _items[productId] = _items[productId]! + 1;
    } else {
      _items[productId] = 1;
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId]! > 1) {
        _items[productId] = _items[productId]! - 1;
      } else {
        _items.remove(productId);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}