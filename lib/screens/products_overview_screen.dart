import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Product_item_provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_Screen.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/drawer.dart';
import '../widgets/gridview_product_builder.dart';

class ProductsOverviewScreen extends StatefulWidget {
  static const routname = 'overview';
  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _isfavorites = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        drawer: myDrawer(),
        appBar: AppBar(
          actions: [
            Consumer<Cart>(
              builder: ((context, cart, child) => Badge(
                    value: cart.length.toString(),
                    color: Theme.of(context).colorScheme.primary,
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
          ),
        ),
        body: FutureBuilder(
            future: Provider.of<Products_Item>(context, listen: false)
                .fetchAndSetProducts(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitFadingCube(
                    size: 50,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              } else {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('error has occured'),
                  );
                } else {
                  return Gridview_products(_isfavorites);
                }
              }
            })),
      ),
    );
  }
}
