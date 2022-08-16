import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Product_item_provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/ordered_items.dart';
import 'package:shop_app/screens/Product_details.dart';
import 'package:shop_app/screens/cart_Screen.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

import 'package:shop_app/themeData.dart';

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
          create: (context) => Products_Item(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => orders(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Mytheme(context),
        initialRoute: '/',
        routes: {
          '/':(context) => ProductsOverviewScreen(),
          Product_detail.id: (context) => Product_detail(),
          Cart_screen.id: (context) => Cart_screen(),
          OrderScreen.id: ((context) => OrderScreen()),
          manage_product.id: (context) => manage_product()
        },
      ),
    );
  }
}
