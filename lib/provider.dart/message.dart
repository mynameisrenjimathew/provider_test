import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../screens/provider_list_screen.dart';

class Message with ChangeNotifier {
  final String id = DateTime.now().toString();
  final String message;

  Message(this.message);
}

class MessageProvider with ChangeNotifier {
  List<Message> _messages = [
    Message('message1'),
    Message('message2'),
    Message('messa3'),
    Message('message4'),
  ];

  List<Message> get messages {
    return [..._messages];
  }

  void addMessage(Message newMessage) {
    _messages.add(newMessage);

    notifyListeners();
  }
}

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });
}

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((productitems) => productitems.isFavorite).toList();
  }

  Product findById(String id) {
    return items.firstWhere((pdct) => pdct.id == id);
  }
}

class CartItem with ChangeNotifier {
  final String id;
  final String title;

  CartItem({
    @required this.id,
    @required this.title,
  });
}

class Cart with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items {
    return [..._items];
  }

  void addItem(String id, String title) {
    _items.add(CartItem(id: id, title: title));
    notifyListeners();
  }

  int get itemCount {
    return items.length;
  }
}
