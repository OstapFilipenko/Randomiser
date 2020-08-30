import 'package:flutter/material.dart';
import 'package:randomiser/Models/List_Of_Items.dart';
import 'package:randomiser/TheDB.dart';

class AddNewList extends StatefulWidget {
  final String listname;

  const AddNewList({Key key, this.listname});

  @override
  _AddNewList createState() => _AddNewList();
}

class _AddNewList extends State<AddNewList> {
  final _newObj = new TextEditingController();
  List<List_Of_Items> _list = new List();
  final theDb = TheDB.instance;

  @override
  void dispose() {
    _newObj.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add new list"),
        ),
        body: new Container(
          child: new Column(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                child: new TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text!';
                    }
                    return null;
                  },
                  controller: _newObj,
                  decoration: new InputDecoration(
                    labelText: "Enter Item",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                ),
              ),
              new RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: new Text("Add new item"),
                  onPressed: () {
                    _insert(widget.listname, _newObj.text);
                    _list.add(new List_Of_Items(
                        item: _newObj.text, name: widget.listname));
                    _newObj.clear();
                    setState(() {});
                  }),
              new RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: new Text("Ready"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              new Text(
                "Items of your list:",
                style: new TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              new Expanded(
                  child: new ListView.separated(
                      separatorBuilder: (context, index) {
                        return new Divider();
                      },
                      itemCount: _list.length,
                      itemBuilder: (BuildContext context, int index) {
                        final item = _list[index];
                        return Dismissible(
                          key: Key(item.getItem()),
                          onDismissed: (direction) {
                            _deleteItem(item.getItem(), item.getName());
                            setState(() {
                              _list.removeAt(index);
                            });
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(item.getItem() + " deleted"),
                            ));
                          },
                          background: Container(color: Colors.red),
                          child: ListTile(
                            title: new Text(item.getItem()),
                          ),
                        );
                      }))
            ],
          ),
        ));
  }

  void _insert(String clName, String item) async {
    Map<String, dynamic> row = {
      TheDB.columnListName: clName,
      TheDB.columnItem: item
    };
    final id = await theDb.insert(row);
    print('inserted row id: $id');
    setState(() {});
  }

  void _deleteItem(String itemName, String listName) async {
    final id = await theDb.queryRowCount();
    final rowsDeleted = await theDb.deleteItem(itemName, listName);
    print('deleted $rowsDeleted row(s): row $id');
  }
}
