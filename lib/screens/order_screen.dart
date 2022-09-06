import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/ordered_items.dart';
import 'package:shop_app/widgets/drawer.dart';
import 'package:shop_app/widgets/orderItem.dart';

import '../providers/ordered_items.dart';

class OrderScreen extends StatefulWidget {
  static const String id = 'OrderScreen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: myDrawer(),
        appBar: AppBar(
          title: const Text('orders'),
        ),
        body: FutureBuilder(
            future:
                Provider.of<orders>(context, listen: false).fetchAndsetOrders(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child:  SpinKitFadingCube(
                    size: 50,
                    color: Theme.of(context).colorScheme.primary,
                  ));
              } else {
                if (snapshot.hasError) {
                  return const Center(child: Text(''));
                } else {
                  return Consumer<orders>(builder: ((context, order, child) {
                    return ListView.builder(
                      itemBuilder: (ctx, index) =>
                          OrderItem(orders: order.items[index]),
                      itemCount: order.items.length,
                    );
                  }));
                }
              }
            })));
  }
}
