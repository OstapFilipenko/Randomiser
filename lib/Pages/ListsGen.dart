import 'package:flutter/material.dart';
import 'package:randomiser/Helper.dart';
import 'package:randomiser/Models/List_Of_Items.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddNewList.dart';

class ListsGen extends StatefulWidget {
  @override
  _ListsGen createState() => _ListsGen();
}
class _ListsGen extends State<ListsGen> {
  SharedPreferences prefs;
  static Helper helper = new Helper();
  List<List_Of_Items> list = helper.getList();

/*
  Future<bool> _saveList() async {
    return await prefs.setStringList("key", _rand);
  }
  List<String> _getList() {
    return prefs.getStringList("key");
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: new ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index){
            final item = list[index];
            return Dismissible(
                    key: Key(item.getName()),
                    onDismissed: (direction){
                      setState(() {
                        list.removeAt(index);
                      });
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text(item.getName() + " deleted"),));
                    },
                    background: Container(color:Colors.red),
                    child: ListTile(
                      title: new Text(item.getName()),
                    ),
                  );
          }
        )
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          print('I was pressed');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>AddNewList())
          );
        },
        tooltip: 'AddNewList',
        child: new Icon(
          Icons.add
        ),
      ),
    );
  }
}