import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/Product_item_provider.dart';
import 'package:shop_app/screens/editProductScreen.dart';

class ManageProductItem extends StatelessWidget {
  final String title;
  final String id;
  final String imageUrl;
  const ManageProductItem(
      {required this.id, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    final scaffMes = ScaffoldMessenger.of(context);
    final safeTheme = Theme.of(context);
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
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, EditProductScreen.id,
                      arguments: id);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                )),
            IconButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text('Are you sure'),
                          content: const Text(
                              'Are you confirm remove this carts from cart item?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text('no')),
                            TextButton(
                                onPressed: () async {
                                  Navigator.of(ctx).pop();
                                  try {
                                    await Provider.of<Products_Item>(context,
                                            listen: false)
                                        .remove(id);
                                    scaffMes.showSnackBar(SnackBar(
                                        backgroundColor:
                                            safeTheme.colorScheme.primary,
                                        content: Text(
                                          'success',
                                          textAlign: TextAlign.center,
                                        )));
                                  } catch (error) {
                                    scaffMes.showSnackBar(
                                      SnackBar(
                                        backgroundColor:
                                            safeTheme.colorScheme.primary,
                                        content: Text(
                                          'deleting failed',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: const Text('yes')),
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ],
        ),
      ),
    );
  }
}
