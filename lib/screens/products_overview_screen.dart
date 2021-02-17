import 'package:flutter/material.dart';

import '../widgets/product_grid.dart';

enum FilterOption { Favorite, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorite = false;

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
                  ])
        ],
      ),
      body: ProductGrid(_showOnlyFavorite),
    );
  }
}
