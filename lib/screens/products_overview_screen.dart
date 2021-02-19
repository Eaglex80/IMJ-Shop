import 'package:flutter/material.dart';
import 'package:imj_shop/providers/cart.dart';
import 'package:imj_shop/providers/products.dart';
import 'package:imj_shop/screens/cart_screen.dart';
import 'package:imj_shop/widgets/app_drawer.dart';
import 'package:imj_shop/widgets/badge.dart';
import 'package:provider/provider.dart';

import '../widgets/product_grid.dart';

enum FilterOption { Favorite, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorite = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context, listen: false)
          .fetchAndSetProduct()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMJ Shop'),
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (FilterOption selectedValue) {
                setState(() {
                  if (selectedValue == FilterOption.Favorite) {
                    _showOnlyFavorite = true;
                  } else {
                    _showOnlyFavorite = false;
                  }
                });
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                        child: Text('Only Favorite'),
                        value: FilterOption.Favorite),
                    PopupMenuItem(
                        child: Text('Show All'), value: FilterOption.All),
                  ]),
          Consumer<Cart>(
            builder: (context, cart, ch) =>
                Badge(value: cart.itemCount.toString(), child: ch),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                }),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductGrid(_showOnlyFavorite),
    );
  }
}
