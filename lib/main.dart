import 'package:flutter/material.dart';

import 'Pages/ColorsGen.dart';
import 'Pages/CountriesGen.dart';
import 'Pages/DicesGen.dart';
import 'Pages/NumbsGen.dart';
import 'Pages/ListsGen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Randomiser',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Randomiser'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _menuChildren = [
    NumbersGen(),
    ColorsGen(),
    ListsGen(),
    DicesGen(),
    CountriesGen()
  ];

 

  void onTappedMenu(int index){
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _menuChildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        onTap: onTappedMenu,
        currentIndex: _currentIndex,
        
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.plus_one),
            title: new Text("Number"),
            backgroundColor: Colors.blue,
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.colorize),
            title: new Text("Color"),
            backgroundColor: Colors.blue,
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: new Text("List"),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.tonality),
            title: new Text("Dice"),
            backgroundColor: Colors.blue,
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.web),
            title: new Text("Country"),
            backgroundColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
