import 'package:flutter/material.dart';
import 'package:shop_app/screens/editProductScreen.dart';

class ManageProductItem extends StatelessWidget {
  final String title;
  final String id;
  final String imageUrl;
  const ManageProductItem({required this.id,required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: () {
              Navigator.pushNamed(context, EditProductScreen.id, arguments: id);
            }, icon: const Icon(Icons.edit)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
