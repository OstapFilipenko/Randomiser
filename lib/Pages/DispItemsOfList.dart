import 'package:flutter/material.dart';
import 'package:randomiser/Models/List_Of_Items.dart';

class DispItemsOfList extends StatefulWidget {
  final List_Of_Items list;

  const DispItemsOfList({Key key, this.list});

  @override
  _DispItemsOfListState createState() => _DispItemsOfListState();
}

class _DispItemsOfListState extends State<DispItemsOfList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.list.getName()),
      ),
      body: Center(child: new Text(widget.list.getItem())),
    );
  }
}
