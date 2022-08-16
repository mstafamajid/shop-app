import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_Screen.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/drawer.dart';

import '../providers/product.dart';
import '../widgets/gridview_product_builder.dart';

class ProductsOverviewScreen extends StatefulWidget {
  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _isfavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(),
      appBar: AppBar(
        actions: [
          Consumer<Cart>(
            builder: ((context, cart, child) => Badge(
                  value: cart.length.toString(),
                  color: Theme.of(context).canvasColor,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Cart_screen.id);
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                )),
          ),
          PopupMenuButton(
            color: Theme.of(context).canvasColor,
            splashRadius: 20,
            itemBuilder: ((context) => [
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (!_isfavorites) _isfavorites = true;
                        });
                      },
                      child: const Text('favorites'),
                    ),
                  ),
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          if (_isfavorites) _isfavorites = false;
                        });
                      },
                      child: const Text(
                        'show all',
                      ),
                    ),
                  ),
                ]),
          ),
        ],
        title: Text(
          'Shop App',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Gridview_products(_isfavorites),
      floatingActionButton: FloatingActionButton(onPressed: (() {})),
    );
  }
}
