import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/ordered_items.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/widgets/CartBuilder.dart';

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
        body: cart.items.isNotEmpty
            ? Column(
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
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                          TextButton(
                              onPressed: () {
                                if (cart.totalAmount != 0) {
                                  Provider.of<orders>(context, listen: false)
                                      .addOrder(cart.items.values.toList(),
                                          cart.totalAmount);
                                  cart.clear();
                                }
                              },
                              child: const Text(
                                'Order Now',
                                style: TextStyle(fontSize: 17),
                              ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: ((ctx, index) => cartItem(
                        productId: cart.items.keys.toList()[index],
                        title: cart.items.values.toList()[index].title,
                        id: cart.items.values.toList()[index].productId,
                        price: cart.items.values.toList()[index].price,
                        quantity: cart.items.values.toList()[index].quantity)),
                    itemCount: cart.items.length,
                  ))
                ],
              )
            : Center(child: Text('add some things')));
  }
}
