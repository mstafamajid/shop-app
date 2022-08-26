import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Product_item_provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/editProductScreen.dart';
import 'package:shop_app/widgets/drawer.dart';
import 'package:shop_app/widgets/manage_product_item.dart';

class manage_product extends StatelessWidget {
  static const id = 'manage_screen';

Future<void> refresh(BuildContext context) async{
await Provider.of<Products_Item>(context, listen: false).fetchAndSetProducts();
}
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products_Item>(context);
    return Scaffold(
      drawer: const myDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditProductScreen.id);
              },
              icon: const Icon(Icons.add))
        ],
        title: const Text('manage your Product'),
      ),
      body: RefreshIndicator (
        onRefresh: () => refresh(context),
        child: ListView.builder(
          itemBuilder: (context, index) => ManageProductItem(
            id: products.items[index].id,
              imageUrl: products.items[index].imgURL,
              title: products.items[index].title),
          itemCount: products.items.length,
        ),
      ),
    );
  }
}
