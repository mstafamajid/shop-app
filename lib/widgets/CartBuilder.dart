// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/cart.dart';

class cartItem extends StatelessWidget {
  String title;
  String productId;
  String id;
  double price;
  int quantity;
  cartItem({
    Key? key,
    required this.productId,
    required this.title,
    required this.id,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Are you sure'),
                content: const Text(
                    'Are you confirm remove this carts from cart item?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);
                      },
                      child: const Text('yes')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: const Text('no')),
                ],
              );
            });
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        padding: const EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.all(10),
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      key: ValueKey(id),
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: ListTile(
            leading: CircleAvatar(
              foregroundColor: Theme.of(context).canvasColor,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: FittedBox(child: Text('\$$price')),
            ),
            title: Text(title),
            subtitle: Text(
              'total: \$${price * quantity}',
              style: const TextStyle(color: Colors.grey),
            ),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
