import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String id;
  final String description;
  final String title;
  final String imgURL;
  final double price;
  bool isfavorite;
  Product({
    required this.id,
    required this.description,
    required this.title,
    required this.imgURL,
    required this.price,
    this.isfavorite = false,
  });

  void toggleFavoriteStatus() {
    isfavorite = !isfavorite;
    notifyListeners();
  }
}
