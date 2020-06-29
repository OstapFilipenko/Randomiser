import 'package:flutter/material.dart';
import 'dart:math';

class ColorsGen extends StatefulWidget {
  @override
  _ColorsGen createState() => _ColorsGen();
}

class _ColorsGen extends State<ColorsGen> {
  int red = 255;
  int green = 255;
  int blue = 255;
  var rng = new Random();
  
  void _randomColor() {
    setState(() {
      red = 0 + rng.nextInt(256-0);
      green = 0 + rng.nextInt(256-0);
      blue = 0 + rng.nextInt(256-0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(red, green, blue, 1),
      body: new Container(
        child: new Center(
          child: new Card(
            color: Colors.white,
            child: new Container(
              padding: EdgeInsets.all(20.0),
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Text("Color rgb: $red, $green, $blue"),
                  new RaisedButton(
                    child: new Text("generate"),
                    onPressed: () {
                      _randomColor();
                    }
                  )
                ],
              ),
            ),
          ),
      ),
      ),
      
      
    );
  }
}
