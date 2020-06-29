import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providertest/provider.dart/message.dart';
import '../widgets/badge.dart';
import './product_detail_screen.dart';

class CartProductScreen extends StatelessWidget {
  static final routeName = '/cart_screen';
  @override
  Widget build(BuildContext context) {
    var products = Provider.of<ProductsProvider>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              color: Colors.redAccent,
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                // Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
        child: GridView.builder(
          itemCount: products.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: products[i],
            child: GridItem(),
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var product = Provider.of<Product>(context);
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments: product.id);
        },
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        leading:
            IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
        title: Text(product.title),
        trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Provider.of<Cart>(context, listen: false).addItem(
                product.id,
                product.title,
              );
              print(product.id + ',' + product.title);
            }),
      ),
    );
  }
}
