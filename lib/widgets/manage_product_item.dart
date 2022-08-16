import 'package:flutter/material.dart';

class ManageProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  const ManageProductItem({required this.imageUrl, required this.title});

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
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
