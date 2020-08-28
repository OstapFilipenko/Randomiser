import 'dart:async';

import 'package:flutter/material.dart';
import 'package:randomiser/Models/List_Of_Items.dart';
import 'package:randomiser/Pages/DispItemsOfList.dart';
import '../TheDB.dart';
import 'AddNewList.dart';
import 'dart:math';

class ListsGen extends StatefulWidget {
  @override
  _ListsGen createState() => _ListsGen();
}

class _ListsGen extends State<ListsGen> {
  final theDb = TheDB.instance;
  List<List_Of_Items> list = new List();
  List<List_Of_Items> randList = new List();

  var rng = new Random();
  @override
  void initState() {
    Timer.run(() async {
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
              itemBuilder: (BuildContext context, int index) {
                final item = list[index];
                return Dismissible(
                  key: Key(item.getName()),
                  onDismissed: (direction) {
                    deleteList(item.getName());
                    setState(() {
                      list.removeAt(index);
                    });
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(item.getName() + " deleted"),
                    ));
                  },
                  background: Container(color: Colors.red),
                  child: new ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DispItemsOfList(
                                      list: item,
                                    )));
                      },
                      title: new Text(item.getName()),
                      trailing: new IconButton(
                        icon: Icon(Icons.find_replace),
                        onPressed: () {
                          showSimpleCustomDialog(context, item.getName());
                          print("generate Button was clicked");
                        },
                      )),
                );
              })),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          print('I was pressed');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNewList()));
        },
        tooltip: 'AddNewList',
        child: new Icon(Icons.add),
      ),
    );
  }

  void deleteList(String listName) async {
    final id = await theDb.queryRowCount();
    final rowsDeleted = await theDb.deleteList(listName);
    print('deleted $rowsDeleted row(s): row $id');
  }

  int numberOf(String listName, List<List_Of_Items> lis) {
    int counter = 0;
    for (List_Of_Items ls in lis) {
      if (ls.getName() == listName) {
        counter++;
      }
    }
    return counter;
  }

  void showSimpleCustomDialog(BuildContext context, String listName) async {
    if (randList.isEmpty) {
      randList = await theDb.queryWhere("$listName");
    } else {
      randList.clear();
      randList = await theDb.queryWhere("$listName");
    }
    setState(() {});
    showDialog(
      context: context,
      builder: (context) {
        String contentText =
            randList[0 + rng.nextInt(randList.length - 0)].getItem();
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Random value of List: $listName"),
              content: Text(contentText),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      contentText =
                          randList[0 + rng.nextInt(randList.length - 0)]
                              .getItem();
                    });
                  },
                  child: Text("get random"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
