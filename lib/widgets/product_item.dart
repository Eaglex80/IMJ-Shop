import 'package:flutter/material.dart';
import 'package:imj_shop/providers/auth.dart';
import 'package:imj_shop/providers/cart.dart';
import 'package:imj_shop/providers/product.dart';
import 'package:imj_shop/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageIrl;
  //
  // ProductItem(this.id, this.title, this.imageIrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
            child: Image.network(product.imageUrl, fit: BoxFit.cover),
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                  arguments: product.id);
            }),
        footer: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
                icon: Icon(product.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  product.toggleFavoriteStatus(authData.token,authData.userId);
                }),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
                icon: Icon(Icons.add_shopping_cart),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  cart.addItem(product.id, product.price, product.title);
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Added item To Cart.'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        }),
                  ));
                }),
          ),
        ),
      ),
    );
  }
}
