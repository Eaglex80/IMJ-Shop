import 'package:flutter/material.dart';
import 'package:imj_shop/providers/orders.dart' as ord;
import 'package:imj_shop/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<ord.Orders>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Your Orders')),
      body: ListView.builder(
          itemCount: ordersData.orders.length,
          itemBuilder: (context, i) => OrderItem(ordersData.orders[i])),
    );
  }
}
