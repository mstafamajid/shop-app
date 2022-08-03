import 'package:flutter/foundation.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/widgets/Product_item.dart';

class Products_Item with ChangeNotifier{

List<Product> _items=[];

List<Product> get items{
  return [..._items];
}

void add_item(Product newProduct){
  _items.add(newProduct);
  notifyListeners();
}
}