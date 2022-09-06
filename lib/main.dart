import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app/providers/Product_item_provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/ordered_items.dart';
import 'package:shop_app/screens/Product_details.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/cart_Screen.dart';
import 'package:shop_app/screens/editProductScreen.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/screens/spash_screen.dart';

import 'package:shop_app/themeData.dart';

import 'providers/auth.dart';
import 'screens/manage_product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: ((context) => Auth()),
          ),
          ChangeNotifierProxyProvider<Auth, Products_Item>(
            create: (context) => Products_Item.seconConstructor(),
            update: (_, auth, previousProduct) => Products_Item(
              auth.token ?? '',
              previousProduct == null ? [] : previousProduct.items,
              auth.userid,
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, orders>(
            create: (context) => orders.second(),
            update: (context, auth, previous) => orders(auth.token ?? '',
                previous == null ? [] : previous.items, auth.userid),
          ),
        ],
        child: Consumer<Auth>(
          builder: ((context, auth, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: Mytheme(context),
                home: auth.isAuth
                    ? ProductsOverviewScreen()
                    : FutureBuilder(
                        future: auth.tryAutoLogging(),
                        builder: (context, snapshot) =>
                            snapshot.connectionState == ConnectionState.waiting
                                ? Splash()
                                : AuthScreen(),
                      ),
                routes: {
                  AuthScreen.routeName: (context) => AuthScreen(),
                  ProductsOverviewScreen.routname: (context) =>
                      ProductsOverviewScreen(),
                  Product_detail.id: (context) => Product_detail(),
                  Cart_screen.id: (context) => Cart_screen(),
                  OrderScreen.id: ((context) => OrderScreen()),
                  manage_product.id: (context) => manage_product(),
                  EditProductScreen.id: (context) => EditProductScreen()
                },
              )),
        ));
  }
}
