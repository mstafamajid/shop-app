// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:shop_app/providers/ordered_items.dart';

class OrderItem extends StatefulWidget {
  final OrderedItem orders;
  const OrderItem({
    Key? key,
    required this.orders,
  }) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.orders.amount}'),
            subtitle: Text(DateFormat('dd/MM/yyyy - hh:mm a')
                .format(widget.orders.orderTime)),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              icon: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
              ),
            ),
          ),
          if (isExpanded)
            Container(
              height: min(
                widget.orders.listofCarts.length * 30 + 100,
                180,
              ),
              child: ListView.builder(
                itemBuilder: ((context, index) => ListTile(
                      title: Text(
                        '${widget.orders.listofCarts[index].title}',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      subtitle:
                          Text('\$${widget.orders.listofCarts[index].price}'),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${widget.orders.listofCarts[index].quantity}x'),
                          Text(
                              '\$${widget.orders.listofCarts[index].price * widget.orders.listofCarts[index].quantity}')
                        ],
                      ),
                    )),
                itemCount: widget.orders.listofCarts.length,
              ),
            )
        ],
      ),
    );
  }
}
