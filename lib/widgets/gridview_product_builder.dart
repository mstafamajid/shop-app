import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Product_item_provider.dart';

import 'Single_Product_item.dart';

class Gridview_products extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
   final products= Provider.of<Products_Item>(context).items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index) =>
        ChangeNotifierProvider (
          create: (context) =>products[index],
           child: single_product_card(
              ),
         )
      ,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}