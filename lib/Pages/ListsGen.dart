import 'dart:async';

import 'package:flutter/material.dart';
import 'package:randomiser/Models/List_Of_Items.dart';
import '../TheDB.dart';
import 'AddNewList.dart';

class ListsGen extends StatefulWidget {
  @override
  _ListsGen createState() => _ListsGen();
}
class _ListsGen extends State<ListsGen> {
  final theDb = TheDB.instance;
  List<List_Of_Items> list = new List();
  @override
  void initState() {
    Timer.run(() async{
        List<List_Of_Items> lol = await theDb.queryGroupBy("name");
        setState(() {
          list = lol;
        });
    });
    
    super.initState();
  }

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
                      deleteList(item.getName());
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


  void deleteList(String listName) async {
    final id = await theDb.queryRowCount();
    final rowsDeleted = await theDb.deleteList(listName);
    print('deleted $rowsDeleted row(s): row $id');
  }

  int numberOf(String listName, List<List_Of_Items> lis){
    int counter = 0;
    for(List_Of_Items ls in lis){
      if(ls.getName() == listName){
        counter++;
      }
    }
    return counter;
  }

}