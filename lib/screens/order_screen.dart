import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/ordered_items.dart';
import 'package:shop_app/widgets/drawer.dart';
import 'package:shop_app/widgets/orderItem.dart';

import '../providers/ordered_items.dart';

class OrderScreen extends StatelessWidget {
  static const String id = 'OrderScreen';
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<orders>(context);
    return Scaffold(
      drawer: myDrawer(),
      appBar: AppBar(
        title: const Text('orders'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => OrderItem(orders: order.items[index]),
        itemCount: order.items.length,
      ),
    );
  }
}
