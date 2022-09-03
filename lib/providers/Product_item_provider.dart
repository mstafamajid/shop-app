import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/myexceptionHandler.dart';
import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;

class Products_Item with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  late String authToken;
  late String userid;
  Products_Item(this.authToken, this._items, this.userid);
  Products_Item.seconConstructor();
  List<Product> get favorites_item {
    return _items.where((element) => element.isfavorite).toList();
  }
// Future<void> showItem()async {
//     Uri url = Uri.parse(
//         'https://shopapp-bd3ee-default-rtdb.firebaseio.com/Products.json');

// }
  Future<void> fetchAndSetProducts() async {
    Uri url = Uri.parse(
        'https://shopapp-bd3ee-default-rtdb.firebaseio.com/Products.json?auth=$authToken');
    try {
      final response = await http.get(url);

      final extraxtedData = json.decode(response.body) == null
          ? null
          : json.decode(response.body) as Map<String, dynamic>;
      final userFavo = await http.get(Uri.parse(
          'https://shopapp-bd3ee-default-rtdb.firebaseio.com/userFavorates/$userid.json?auth=$authToken'));
      final favodata = jsonDecode(userFavo.body);
      List<Product> loadedData = [];
      if (extraxtedData == null) return;
      extraxtedData.forEach((productId, productData) {
        loadedData.add(Product(
            id: productId,
            description: productData['description'],
            title: productData['title'],
            imgURL: productData['imgUrl'],
            price: double.parse(productData['price'].toString()),
            isfavorite:
                favodata == null ? false : favodata[productId] ?? false));
      });
      _items = loadedData;
      print(_items);
      notifyListeners();
    } catch (error) {
      print('eeeerrrrrroooorrrrrrrr ${error.toString()}');
      rethrow;
    }
  }

  Future<void> addItem(Product newProduct) async {
    Uri url = Uri.parse(
        'https://shopapp-bd3ee-default-rtdb.firebaseio.com/Products.json?auth=$authToken');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imgUrl': newProduct.imgURL,
          }));

      _items.add(Product(
          id: json.decode(response.body)['name'],
          description: newProduct.description,
          title: newProduct.title,
          imgURL: newProduct.imgURL,
          price: newProduct.price));
    } catch (e) {
      print(e);
      rethrow;
    }

    notifyListeners();
  }

  Future<void> updateProduct(Product newProduct) async {
    Uri url = Uri.parse(
        'https://shopapp-bd3ee-default-rtdb.firebaseio.com/Products/${newProduct.id}.json?auth=$authToken');
    await http.patch(url,
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'price': newProduct.price,
          'imgUrl': newProduct.imgURL,
        }));
    _items.remove(findProductById(newProduct.id));
    _items.add(newProduct);
    notifyListeners();
  }

  Future<void> remove(String id) async {
    final indexProduct = _items.indexWhere((element) => element.id == id);
    Product? product = _items[indexProduct];
    print(product.id);
    _items.removeAt(indexProduct);
    notifyListeners();
    Uri url = Uri.parse(
        'https://shopapp-bd3ee-default-rtdb.firebaseio.com/Products/$id.json?auth=$authToken');
    final value = await http.delete(url);
    if (value.statusCode >= 400) {
      _items.insert(indexProduct, product);
      notifyListeners();
      throw const httpexception('fault');
    }

    product = null;
  }

  Product findProductById(String id) {
    return _items.firstWhere(
      (element) => element.id == id,
    );
  }
}
