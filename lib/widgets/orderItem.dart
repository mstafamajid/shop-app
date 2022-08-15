// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:shop_app/providers/ordered_items.dart';

class OrderItem extends StatelessWidget {
  final OrderedItem orders;
  const OrderItem({
    Key? key,
    required this.orders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${orders.amount}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy - hh:mm a').format(orders.orderTime)),
            trailing:
                IconButton(onPressed: () {}, icon: Icon(Icons.expand_more)),
          )
        ],
      ),
    );
  }
}
