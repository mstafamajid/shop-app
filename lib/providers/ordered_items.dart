// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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

  late String token;
  late String userid;
  orders(this.token, this._items, this.userid);
  orders.second();

  Future<bool> fetchAndsetOrders() async {
    Uri url = Uri.parse(
        'https://shopapp-bd3ee-default-rtdb.firebaseio.com/Orders.json?auth=$token&orderBy="userId"&equalTo="$userid"');
    final response = await http.get(url);
    List<OrderedItem> loadedData = [];
    final extraxtedData = json.decode(response.body) == null
        ? null
        : json.decode(response.body) as Map<String, dynamic>;
    if (extraxtedData == null || extraxtedData.isEmpty) {
      print('aaaaaaaaaaaaaaaaaaa');
      return false;
    }

    extraxtedData.forEach((key, ordered_item) {
      loadedData.insert(
        0,
        OrderedItem(
          id: key,
          amount: ordered_item['totalAmount'],
          listofCarts: (ordered_item['products'] as List<dynamic>)
              .map((carts) => CartItem(
                  productId: carts['productId'],
                  title: carts['title'],
                  price: carts['price'],
                  quantity: carts['quantity']))
              .toList(),
          orderTime: DateTime.parse(ordered_item['dateTime']),
        ),
      );
    });
    _items = loadedData;

    notifyListeners();
    return true;
  }

  Future<void> addOrder(List<CartItem> listOfOrder, double total) async {
    Uri url = Uri.parse(
        'https://shopapp-bd3ee-default-rtdb.firebaseio.com/Orders.json?auth=$token');
    final dateStamp = DateTime.now();
    try {
      final response = await http.post(url,
          body: json.encode({
            'userId': userid,
            'totalAmount': total,
            'dateTime': dateStamp.toIso8601String(),
            'products': listOfOrder
                .map((cartProduct) => {
                      'productId': cartProduct.productId,
                      'title': cartProduct.title,
                      'price': cartProduct.price,
                      'quantity': cartProduct.quantity
                    })
                .toList()
          }));

      _items.insert(
        0,
        OrderedItem(
          id: json.decode(response.body)['name'],
          amount: total,
          listofCarts: listOfOrder,
          orderTime: DateTime.now(),
        ),
      );
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
