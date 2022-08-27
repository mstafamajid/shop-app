import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/myexceptionHandler.dart';

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

  Future<void> toggleFavoriteStatus() async {
    var oldstate = isfavorite;
    isfavorite = !isfavorite;
    notifyListeners();
    Uri url = Uri.parse(
        'https://shopapp-bd3ee-default-rtdb.firebaseio.com/Products/$id.jon');
try {
    final resposne = await http.patch(
      url,
      body: json.encode(
        ({'isFavo': isfavorite}),
      ),
    );
    if (resposne.statusCode >= 400) {
      isfavorite = oldstate;
      notifyListeners();
      throw const httpexception('failed');
    }
  
} catch (e) {
    isfavorite = oldstate;
      notifyListeners();
  rethrow;
}
  }
}
