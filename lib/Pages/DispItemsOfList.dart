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
  final itemcontroller = TextEditingController();

  @override
  void dispose() {
    itemcontroller.dispose();
    super.dispose();
  }

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
              child: new ListView.separated(
                  separatorBuilder: (context, index) {
                    return new Divider();
                  },
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
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          print('I was pressed');
          addItemDialog();
        },
        tooltip: 'Add new item to list',
        child: new Icon(Icons.add),
      ),
    );
  }

  void addItemDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Add new item"),
              content: new TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text!';
                  }
                  return null;
                },
                controller: itemcontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Item',
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close me!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Add'),
                  onPressed: () {
                    _insert(itemcontroller.text);
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  void _insert(String item) async {
    Map<String, dynamic> row = {
      TheDB.columnListName: widget.list.getName(),
      TheDB.columnItem: item
    };
    final id = await theDb.insert(row);
    setState(() {
      items.add(
          new List_Of_Items(id: id, item: item, name: widget.list.getName()));
    });
  }
}
