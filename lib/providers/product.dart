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

  Future<void> toggleFavoriteStatus(String token, String userid) async {
    var oldstate = isfavorite;
    isfavorite = !isfavorite;
    notifyListeners();
    Uri url = Uri.parse(
        'https://shopapp-bd3ee-default-rtdb.firebaseio.com/userFavorates/$userid/$id.json?auth=$token');
    try {
      final resposne = await http.put(
        url,
        body: json.encode(
          (isfavorite),
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
