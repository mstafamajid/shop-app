import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Product_item_provider.dart';

import 'Product_item.dart';

class Gridview_products extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
   final products= Provider.of<Products_Item>(context);
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.items.length,
      itemBuilder: (context, index) {
        return single_product_card(
            id: products.items[index].id,
            imgURL: products.items[index].imgURL,
            title: products.items[index].title);
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}