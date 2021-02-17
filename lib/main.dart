import 'package:flutter/material.dart';
import 'package:imj_shop/screens/product_detail_screen.dart';
import 'package:imj_shop/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        title: 'IMJ Shop',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.blueAccent,
          fontFamily: 'Lato',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
        },
        home: ProductsOverviewScreen(),
      ),
    );
  }
}
