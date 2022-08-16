import 'package:flutter/foundation.dart';

class CartItem with ChangeNotifier {
  String productId;
  String title;
  double price;
  int quantity;
  CartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  int get length {
    int total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingItem) => CartItem(
            productId: existingItem.productId,
            title: existingItem.title,
            price: existingItem.price,
            quantity: existingItem.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              productId: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void undoAddedItem(String productID) {
    if (!_items.containsKey(productID)) {
      return;
    }
    if (_items[productID]!.quantity == 1) {
      removeItem(productID);
    } else {
      _items.update(
          productID,
          (existingItem) => CartItem(
              productId: existingItem.productId,
              title: existingItem.title,
              price: existingItem.price,
              quantity: existingItem.quantity - 1));
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
