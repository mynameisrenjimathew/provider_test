import 'dart:async';

import 'package:flutter/material.dart';
import '../provider.dart/message.dart';
import 'package:provider/provider.dart';
import './cart_items_provider.dart';

class ProviderListScreen extends StatefulWidget {
  @override
  _ProviderListScreenState createState() => _ProviderListScreenState();
}

class _ProviderListScreenState extends State<ProviderListScreen> {
  final _messageController = TextEditingController();
  StreamController _streamController;
  Stream _stream;

  @override
  void initState() {
    _streamController = StreamController();
    _stream = _streamController.stream;
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var messagesCls = Provider.of<MessageProvider>(context);
    var messages = messagesCls.messages;
    if (messages.length == 0) {
      _streamController.add(null);
    } else {
      _streamController.add('done');
    }
    print(_messageController);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () {
                Navigator.of(context).pushNamed(CartProductScreen.routeName);
              })
        ],
        title: Text('Provider', textAlign: TextAlign.center),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(58.0),
          child: Container(
            margin: const EdgeInsets.only(left: 12.0, bottom: 8.0, right: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Message",
                contentPadding: const EdgeInsets.only(left: 24.0),
                border: InputBorder.none,
              ),
              controller: _messageController,
              onChanged: (value) {
                // _streamController.add('loading');
              },
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _stream,
        builder: (ctx, snapshot) {
          if (snapshot.data == null) {
            return Center(child: Text('Enter Some Message'));
          }
          if (snapshot.data == 'done') {
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                          value: messages[i],
                          child: ListTile(title: Text(messages[i].message)))),
                ),
              ],
            );
          }
          if (snapshot.data == 'loading') {
            return Center(child: CircularProgressIndicator());
          }

          return Text('Hi');
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            messagesCls.addMessage(Message(_messageController.text));
            _messageController.clear();
          }),
    );
  }
}
