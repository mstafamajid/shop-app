import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/Product_details.dart';

import '../providers/product.dart';

class single_product_card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffMes = ScaffoldMessenger.of(context);
    final safeTheme = Theme.of(context);
    final singleProduct = Provider.of<Product>(context, listen: false);
    final authData=Provider.of<Auth>(context).token;
    final cart = Provider.of<Cart>(context, listen: false);
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(Product_detail.id, arguments: singleProduct.id),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(85, 0, 0, 0),
                blurRadius: 5,
                offset: Offset(0, 6),
              )
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GridTile(
            footer: GridTileBar(
              title: Text(
                singleProduct.title,
                textAlign: TextAlign.center,
              ),
              backgroundColor:
                  Theme.of(context).colorScheme.primary.withAlpha(200),
              leading: Consumer<Product>(
                builder: (ctx, singleProduct, child) => IconButton(
                  onPressed: () async {
                    try {
                      await singleProduct.toggleFavoriteStatus(authData!);
                    } catch (e) {
                      scaffMes.showSnackBar(
                        SnackBar(
                          backgroundColor: safeTheme.colorScheme.primary,
                          content: Text(
                            'operation failed',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                      (singleProduct).isfavorite
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: Theme.of(context).canvasColor),
                ),
              ),
              trailing: IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    cart.addItem(singleProduct.id, singleProduct.title,
                        singleProduct.price);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction(
                            textColor: Colors.white,
                            label: 'undo',
                            onPressed: () {
                              cart.undoAddedItem(singleProduct.id);
                            }),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        content: Text(
                          '${singleProduct.title} was added',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                  color: Theme.of(context).canvasColor),
            ),
            child: Hero(
              tag: singleProduct.id,
              child: Image.network(
                singleProduct.imgURL,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
