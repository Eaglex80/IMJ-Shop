import 'package:flutter/material.dart';
import 'package:imj_shop/providers/cart.dart';
import 'package:imj_shop/providers/orders.dart';
import 'package:imj_shop/screens/cart_screen.dart';
import 'package:provider/provider.dart';

import './providers/products.dart';
import 'screens/product_detail_screen.dart';
import 'screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Products(),
          ),
          ChangeNotifierProvider(
            create: (context) => Cart(),
          ),
          ChangeNotifierProvider(
            create: (context) => Orders(),
          ),
        ],
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
            CartScreen.routeName: (_) => CartScreen(),
          },
          home: ProductsOverviewScreen(),
        ));
  }
}
