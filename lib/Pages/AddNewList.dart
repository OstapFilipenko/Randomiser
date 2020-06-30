import 'package:flutter/material.dart';
import 'package:randomiser/Helper.dart';
import 'package:randomiser/Models/List_Of_Items.dart';
import 'package:randomiser/Pages/ListsGen.dart';

class AddNewList extends StatefulWidget {
  @override
  _AddNewList createState() => _AddNewList();
}
class _AddNewList extends State<AddNewList> {  
  final _newObj = new TextEditingController();
  final _nameOfList = new TextEditingController();
  List<String> _list = new List();
  Helper _helper = new Helper();
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
                _list.add(_newObj.text);
                _newObj.clear();
                setState(() { });
              }
            ),
            new RaisedButton(
              onPressed: (){
                _helper.addToList(List_Of_Items(_nameOfList.text, _list));
                _nameOfList.clear();
                setState(() {});
                Navigator.pop(context);
              },
              child: new Text("Ready")
            ),
            new Expanded(
              child: new ListView.builder(
                itemCount: _list.length,
                itemBuilder: (BuildContext context, int index){
                  final item  = _list[index];
                  return Dismissible(
                    key: Key(item),
                    onDismissed: (direction){
                      setState(() {
                        _list.removeAt(index);
                      });
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text("$item deleted"),));
                    },
                    background: Container(color:Colors.red),
                    child: ListTile(
                      title: new Text('$item'),
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
}