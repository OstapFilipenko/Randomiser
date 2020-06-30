import 'package:flutter/material.dart';
class AddNewList extends StatefulWidget {
  @override
  _AddNewList createState() => _AddNewList();
}
class _AddNewList extends State<AddNewList> {  
  final _newObj = new TextEditingController();
  List<String> _list = new List();

  @override
  void dispose(){
    _newObj.dispose();
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