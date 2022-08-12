// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/Product_item_provider.dart';

import 'Single_Product_item.dart';

class Gridview_products extends StatelessWidget {
  bool isfavorites;
  Gridview_products(
    this.isfavorites,
  );

  @override
  Widget build(BuildContext context) {
    print('isfavo====>>>>> $isfavorites');
    final products = isfavorites
        ? Provider.of<Products_Item>(context).favorites_item
        : Provider.of<Products_Item>(context).items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: single_product_card(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
