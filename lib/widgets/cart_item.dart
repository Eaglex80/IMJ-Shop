import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imj_shop/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Icon(Icons.delete, color: Colors.white, size: 40),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(child: Text('\$ $price'))),
            ),
            title: Text(title),
            subtitle: Text('Total : \$ ${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are You Sure ?'),
            content: Text('Do You really want to remove item from cart?'),
            actions: [
              FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  }),
              FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  }),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
    );
  }
}
