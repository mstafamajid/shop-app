import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;

class Products_Item with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favorites_item {
    return _items.where((element) => element.isfavorite).toList();
  }
// Future<void> showItem()async {
//     Uri url = Uri.parse(
//         'https://shopapp-bd3ee-default-rtdb.firebaseio.com/Products.json');

// }
  Future<void> fetchAndSetProducts() async {
    Uri url = Uri.parse(
        'https://shopapp-bd3ee-default-rtdb.firebaseio.com/Products.json');
    try {
      final response = await http.get(url);
      final extraxtedData = json.decode(response.body) as Map<String, dynamic>;
      List<Product> loadedData = [];
      extraxtedData.forEach((productId, productData) {
        loadedData.add(Product(
            id: productId,
            description: productData['description'],
            title: productData['title'],
            imgURL: productData['imgUrl'],
            price: 
         double.parse( productData['price'].toString() ),
            
            isfavorite: productData['isFavo'] as bool));
      }
      );
      _items=loadedData;
      notifyListeners();
    } catch (error) {
      print('eeeerrrrrroooorrrrrrrr ${error.toString()}');
      rethrow;
    }
  }

  Future<void> addItem(Product newProduct) async {
    Uri url = Uri.parse(
        'https://shopapp-bd3ee-default-rtdb.firebaseio.com/Products.json');
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imgUrl': newProduct.imgURL,
            'isFavo': newProduct.isfavorite
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

  Future<void> updateProduct(Product newProduct) async{
        Uri url = Uri.parse(
        'https://shopapp-bd3ee-default-rtdb.firebaseio.com/Products/${newProduct.id}.json');
        http.patch(url,body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'price':newProduct.price,
          'imgUrl':newProduct.imgURL,
        }));
    _items.remove(findProductById(newProduct.id));
    _items.add(newProduct);
    notifyListeners();
  }

  void remove(String id) {
    final indexProduct=_items.indexWhere((element) => element.id==id);
 Product? product=_items[indexProduct];
  _items.removeAt(indexProduct);
  print(product.id);
      Uri url = Uri.parse(
        'https://shopapp-bd3ee-default-rtdb.firebaseio.com/Products/$id.json');
        http.delete(url).then((value) => product=null).catchError((error){
          _items.insert(indexProduct, product!);
        });
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Product findProductById(String id) {
    return _items.firstWhere(
      (element) => element.id == id,
    );
  }
}
