import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/screens/manage_product.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

class myDrawer extends StatelessWidget {
  const myDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Shop App'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('shop'),
            onTap: () => Navigator.pushReplacementNamed(
                context, ProductsOverviewScreen.routname),
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('orders'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, OrderScreen.id),
          ),
          ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('manage product'),
              onTap: () =>
                  Navigator.pushReplacementNamed(context, manage_product.id)),
          Spacer(),
          ListTile(
              leading: const Icon(Icons.logout_sharp),
              title: const Text('logout'),
              onTap: () {
                Navigator.of(context).pop();
                Provider.of<Auth>(context, listen: false).logout();
                Navigator.of(context).pushReplacementNamed('/');
              }),
        ],
      ),
    );
  }
}
