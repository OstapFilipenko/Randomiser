import 'package:flutter/material.dart';
import 'package:randomiser/Models/List_Of_Items.dart';
import 'package:randomiser/TheDB.dart';

class AddNewList extends StatefulWidget {
  @override
  _AddNewList createState() => _AddNewList();
}
class _AddNewList extends State<AddNewList> {  
  final _newObj = new TextEditingController();
  final _nameOfList = new TextEditingController();
  List<List_Of_Items> _list = new List();
  final theDb = TheDB.instance;

  @override
  void dispose(){
    _newObj.dispose();
    _nameOfList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new List"),
      ),
      body: new Container(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Container(
                  width: 100,
                  child: new Text(
                    "Name of the List: "
                  ),
                ),
                new Container(
                  width: 100,
                  child: new TextField(
                    controller: _nameOfList,
                    decoration: new InputDecoration.collapsed(
                      hintText: "Name"
                    ),
                  textAlign: TextAlign.center,
                  )
                )
                
              ],
            ),
            new Text("Your List includes:"),
            new TextField(
              controller: _newObj,
              decoration: new InputDecoration.collapsed(
                hintText: "Item"
              ),
              textAlign: TextAlign.center,
            ),
            new RaisedButton(
              child: new Text("add new Item"),
              onPressed: (){
                _insert(_nameOfList.text, _newObj.text);
                _list.add(new List_Of_Items(item: _newObj.text, name: _nameOfList.text));
                _newObj.clear();
                setState(() { });
              }
            ),
            new RaisedButton(
              child: new Text("Ready"),
              onPressed: (){
                //_query();
                Navigator.pop(context);
              },

            ),
            new Expanded(
              child: new ListView.builder(
                itemCount: _list.length,
                itemBuilder: (BuildContext context, int index){
                  final item  = _list[index];
                  return Dismissible(
                    key: Key(item.getItem()),
                    onDismissed: (direction){
                      _deleteItem(item.getItem(), item.getName());
                      setState(() {
                        _list.removeAt(index);
                      });
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text("$item deleted"),));
                    },
                    background: Container(color:Colors.red),
                    child: ListTile(
                      title: new Text(item.getItem()),
                      subtitle: new Text("Liste: " + item.getName() + " | ID: " + item.getID().toString()),
                    ),
                  );
                }
              )
            )
            
          ],
        ),
      )
    );
  }


  void _insert(String clName, String item) async {
    Map<String, dynamic> row = {
      TheDB.columnListName: clName,
      TheDB.columnItem: item
    };
    final id = await theDb.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await theDb.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row.toString()));
  }

  void _deleteItem(String itemName, String listName) async {
    final id = await theDb.queryRowCount();
    final rowsDeleted = await theDb.deleteItem(itemName, listName);
    print('deleted $rowsDeleted row(s): row $id');
  }
}