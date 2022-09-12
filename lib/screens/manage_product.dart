import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Product_item_provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/editProductScreen.dart';
import 'package:shop_app/widgets/drawer.dart';
import 'package:shop_app/widgets/manage_product_item.dart';

class manage_product extends StatelessWidget {
  static const id = 'manage_screen';

  Future<bool> refresh(BuildContext context) async {
    return await Provider.of<Products_Item>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: refresh(context),
        builder: (context, snapshot) => snapshot.data == false
            ? RefreshIndicator(
                onRefresh: () => refresh(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      child: Lottie.asset(
                        'assets/lottie/noItem.json',
                      ),
                    ),
                    Text(
                      'No added own items yet!',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 40),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            : snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: SpinKitFadingCube(
                      size: 90,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () => refresh(context),
                    child: Consumer<Products_Item>(
                      builder: (context, products, child) => ListView.builder(
                        itemBuilder: (context, index) => ManageProductItem(
                            id: products.items[index].id,
                            imageUrl: products.items[index].imgURL,
                            title: products.items[index].title),
                        itemCount: products.items.length,
                      ),
                    ),
                  ),
      ),
    );
  }
}
