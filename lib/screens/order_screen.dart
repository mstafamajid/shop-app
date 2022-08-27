import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/ordered_items.dart';
import 'package:shop_app/widgets/drawer.dart';
import 'package:shop_app/widgets/orderItem.dart';

import '../providers/ordered_items.dart';

class OrderScreen extends StatefulWidget {
  static const String id = 'OrderScreen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isInit=true;
  bool isloading=true;
  @override
  void didChangeDependencies() async{
   if(isInit){
    await Provider.of<orders>(context, listen: false).fetchAndsetOrders();
    setState(() {
      isloading=false;
    });
   }
   isInit=false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<orders>(context);
    return Scaffold(
      drawer: myDrawer(),
      appBar: AppBar(
        title: const Text('orders'),
      ),
      body: isloading?  Center(child: CircularProgressIndicator()): ListView.builder(
        itemBuilder: (ctx, index) => OrderItem(orders: order.items[index]),
        itemCount: order.items.length,
      ),
    );
  }
}
