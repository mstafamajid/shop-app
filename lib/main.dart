import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Product_item_provider.dart';
import 'package:shop_app/screens/Product_details.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'package:shop_app/themeData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products_Item(),
      child: MaterialApp(
        theme: Mytheme(context),
        home: ProductsOverviewScreen(),
        routes: {
          Product_detail.id:(context) => Product_detail()
        },
      ),
    );
  }
}
