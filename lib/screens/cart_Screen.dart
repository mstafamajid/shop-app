import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/ordered_items.dart';
import 'package:shop_app/screens/order_screen.dart';
import 'package:shop_app/widgets/CartBuilder.dart';

class Cart_screen extends StatefulWidget {
  static const id = 'cartScreen';

  @override
  State<Cart_screen> createState() => _Cart_screenState();
}

class _Cart_screenState extends State<Cart_screen> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final scaffmesg = ScaffoldMessenger.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your carts'),
          centerTitle: true,
        ),
        body: cart.items.isNotEmpty
            ? !isloading
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
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
                                  onPressed: () async {
                                    if (cart.totalAmount >= 0) {
                                      setState(() {
                                        isloading = true;
                                      });
                                      try {
                                        await Provider.of<orders>(context,
                                                listen: false)
                                            .addOrder(
                                                cart.items.values.toList(),
                                                cart.totalAmount);
                                        cart.clear();
                                        setState(() {
                                          isloading = false;
                                        });
                                        scaffmesg.hideCurrentSnackBar();
                                        scaffmesg.showSnackBar(SnackBar(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            content: Text(
                                              'Added order',
                                              textAlign: TextAlign.center,
                                            )));
                                      } catch (e) {
                                        setState(() {
                                          isloading = false;
                                        });
                                        await showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                                  title: Text('error occured'),
                                                  content: Text(
                                                      'something went wrong please retry later'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Text('OK'))
                                                  ],
                                                ));
                                      }
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
                            quantity:
                                cart.items.values.toList()[index].quantity)),
                        itemCount: cart.items.length,
                      ))
                    ],
                  )
                : Center(
                    child: SpinKitFadingCube(
                      size: 50,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Lottie.asset('assets/lottie/noItem.json'),
                  ),
                  Text(
                    'No Items yet!',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 40),
                    textAlign: TextAlign.center,
                  )
                ],
              ));
  }
}
