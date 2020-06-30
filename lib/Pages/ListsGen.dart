import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddNewList.dart';

class ListsGen extends StatefulWidget {
  @override
  _ListsGen createState() => _ListsGen();
}
class _ListsGen extends State<ListsGen> {
  SharedPreferences prefs;
  List<List<String>> _rand = new List();
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
        child: new Text("Lists"),
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