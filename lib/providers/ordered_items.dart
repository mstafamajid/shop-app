// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:shop_app/providers/cart.dart';

class OrderedItem {
  final String id;
  final double amount;
  final List<CartItem> listofCarts;
  final DateTime orderTime;
  OrderedItem({
    required this.id,
    required this.amount,
    required this.listofCarts,
    required this.orderTime,
  });
}

class orders with ChangeNotifier {
  List<OrderedItem> _items = [];

  List<OrderedItem> get items {
    return [..._items];
  }

  void addOrder(List<CartItem> listOfOrder, double total) {
    _items.insert(
      0,
      OrderedItem(
        id: DateTime.now().toString(),
        amount: total,
        listofCarts: listOfOrder,
        orderTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
