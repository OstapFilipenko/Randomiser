import 'dart:async';

import 'package:flutter/material.dart';
import 'package:randomiser/Models/List_Of_Items.dart';
import 'package:randomiser/TheDB.dart';

class DispItemsOfList extends StatefulWidget {
  final List_Of_Items list;

  const DispItemsOfList({Key key, this.list});

  @override
  _DispItemsOfListState createState() => _DispItemsOfListState();
}

class _DispItemsOfListState extends State<DispItemsOfList> {
  List<List_Of_Items> items = new List();
  final theDb = TheDB.instance;

  @override
  void initState() {
    Timer.run(() async {
      List<List_Of_Items> lol = await theDb.queryWhere(widget.list.getName());
      setState(() {
        items = lol;
      });
    });
    super.initState();
  }

  void _deleteItem(String itemName, String listName) async {
    final id = await theDb.queryRowCount();
    final rowsDeleted = await theDb.deleteItem(itemName, listName);
    print('deleted $rowsDeleted row(s): row $id');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.list.getName()),
      ),
      body: items.isEmpty
          ? CircularProgressIndicator()
          : Center(
              child: new ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = items[index];
                    return Dismissible(
                      key: Key(item.getItem()),
                      onDismissed: (direction) {
                        _deleteItem(item.getItem(), item.getName());
                        setState(() {
                          items.removeAt(index);
                        });
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(item.getItem() + " deleted"),
                        ));
                      },
                      background: Container(color: Colors.red),
                      child: new ListTile(
                        title: new Text(item.getItem()),
                      ),
                    );
                  })),
    );
  }
}
