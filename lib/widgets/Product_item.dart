import 'package:flutter/material.dart';

class single_product_card extends StatelessWidget {
  final String imgURL;
  final String id;
  final String title;

  single_product_card({required this.id, required this.imgURL, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              title,
              textAlign: TextAlign.center,
            ),
            backgroundColor:
                Theme.of(context).colorScheme.primary.withAlpha(200),
            leading: Icon(
              Icons.favorite,
              color: Theme.of(context).canvasColor,
            ),
            trailing:
                Icon(Icons.shopping_cart, color: Theme.of(context).canvasColor),
          ),
          child: Image.network(
            imgURL,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
