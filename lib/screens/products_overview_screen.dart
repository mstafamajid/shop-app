import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/gridview_product_builder.dart';

class ProductsOverviewScreen extends StatelessWidget {
  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shop App',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Gridview_products(),
      floatingActionButton: FloatingActionButton(onPressed: (() {})),
    );
  }
}
