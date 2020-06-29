import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providertest/screens/cart_items_provider.dart';
import './provider.dart/message.dart';
import './screens/provider_list_screen.dart';
import './screens/product_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MessageProvider()),
        ChangeNotifierProvider(create: (ctx) => ProductsProvider()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.purple,
        accentColor: Colors.amberAccent),
        home: ProviderListScreen(),
        routes: {
          CartProductScreen.routeName: (ctx) => CartProductScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),

        },
      ),
    );
  }
}
