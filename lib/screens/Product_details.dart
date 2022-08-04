import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app/providers/Product_item_provider.dart';

class Product_detail extends StatelessWidget {
 static const id='Product_detail';

  @override
  Widget build(BuildContext context) {

final id=ModalRoute.of(context)!.settings.arguments as String;
final LoadedProduct=Provider.of<Products_Item>(context, listen: false).findProductById(id);

    return Scaffold(
appBar: AppBar(
  title: Text(LoadedProduct.title),
),
    );
  }
}