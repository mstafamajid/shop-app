import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;

class Products_Item with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 20.0,
      imgURL:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 25.0,
      imgURL:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 30.0,
      imgURL: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 10.0,
      imgURL:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favorites_item {
    return _items.where((element) => element.isfavorite).toList();
  }

  Future<void> addItem(Product newProduct) {
    Uri url = Uri.parse(
        'https://shopapp-bd3ee-default-rtdb.firebaseio.com/Products.json');
    return http
        .post(url,
            body: json.encode({
              'title': newProduct.title,
              'description': newProduct.description,
              'price': newProduct.price.toString(),
              'imgUrl': newProduct.imgURL,
              'id': newProduct.id
            }))
        .then((response) {
      _items.add(Product(
          id: json.decode(response.body)['name'],
          description: newProduct.description,
          title: newProduct.title,
          imgURL: newProduct.imgURL,
          price: newProduct.price));
      notifyListeners();
      
    }).catchError((error){
throw error;
    });
  }

  void updateProduct(Product newProduct) {
    _items.remove(findProductById(newProduct.id));
    _items.add(newProduct);
    notifyListeners();
  }

  void remove(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Product findProductById(String id) {
    return _items.firstWhere(
      (element) => element.id == id,
    );
  }
}
