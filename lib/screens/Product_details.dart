import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app/providers/Product_item_provider.dart';

class Product_detail extends StatelessWidget {
  static const id = 'Product_detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final LoadedProduct =
        Provider.of<Products_Item>(context, listen: false).findProductById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(LoadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Hero(
                tag: LoadedProduct.id,
                child: Image.network(
                  LoadedProduct.imgURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              ' \$${LoadedProduct.price}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Text(
                LoadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
