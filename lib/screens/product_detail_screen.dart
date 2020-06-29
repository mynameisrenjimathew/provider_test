import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider.dart/message.dart';
import '../widgets/badge.dart';

class ProductDetailScreen extends StatelessWidget {
  static final routeName = '/producu_detail';

  @override
  Widget build(BuildContext context) {
    var productId = ModalRoute.of(context).settings.arguments as String;
    var loadedProduct =
        Provider.of<ProductsProvider>(context).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
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
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 400,
            width: double.infinity,
            child: Image.network(loadedProduct.imageUrl),
          ),
          ListTile(
            title: Text(loadedProduct.description),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.shopping_cart),
          onPressed: () {
            Provider.of<Cart>(context, listen: false)
                .addItem(loadedProduct.id, loadedProduct.title);
          }),
    );
  }
}
