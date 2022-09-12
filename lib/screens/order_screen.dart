import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
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
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == false) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        child: Lottie.asset(
                          'assets/lottie/noOrder.json',
                        ),
                      ),
                      Text(
                        'No Orders yet!',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 40),
                        textAlign: TextAlign.center,
                      )
                    ],
                  );
                } else {
                  return Consumer<orders>(builder: ((context, order, child) {
                    return ListView.builder(
                      itemBuilder: (ctx, index) =>
                          OrderItem(orders: order.items[index]),
                      itemCount: order.items.length,
                    );
                  }));
                }
              } else if (ConnectionState.waiting == snapshot.connectionState) {
                return Center(
                    child: SpinKitFadingCube(
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,
                ));
              } else {
                return Text('data');
              }
            })));
  }
}
