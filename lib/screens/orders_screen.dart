import 'package:flutter/material.dart';
import 'package:imj_shop/providers/orders.dart' as ord;
import 'package:imj_shop/providers/orders.dart';
import 'package:imj_shop/widgets/app_drawer.dart';
import 'package:imj_shop/widgets/order_item.dart' as oi;
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<ord.Orders>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Your Orders')),
      drawer: AppDrawer(),
      body: _isLoading
          ? CircularProgressIndicator()
          : ListView.builder(
              itemCount: ordersData.orders.length,
              itemBuilder: (context, i) => oi.OrderItem(ordersData.orders[i])),
    );
  }
}
