import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/Product_details.dart';

import '../providers/product.dart';

class single_product_card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final singleProduct = Provider.of<Product>(context, listen: false);
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
                  onPressed: () => singleProduct.toggleFavoriteStatus(),
                  icon: Icon(
                      (singleProduct).isfavorite
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: Theme.of(context).canvasColor),
                ),
              ),
              trailing: Icon(Icons.shopping_cart,
                  color: Theme.of(context).canvasColor),
            ),
            child: Image.network(
              singleProduct.imgURL,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
