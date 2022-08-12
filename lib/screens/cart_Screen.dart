import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class Cart_screen extends StatelessWidget {
  static const id = 'cartScreen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your carts'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    const Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Order Now',
                          style: TextStyle(fontSize: 17),
                        ))
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
