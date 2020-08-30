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
      red = 0 + rng.nextInt(256 - 0);
      green = 0 + rng.nextInt(256 - 0);
      blue = 0 + rng.nextInt(256 - 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(red, green, blue, 1),
      body: new Container(
        child: new Center(
          child: new Card(
            elevation: 50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            shadowColor: Colors.black,
            color: Colors.white,
            child: new Container(
              padding: EdgeInsets.all(20.0),
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new RichText(
                    text: new TextSpan(
                        style: new TextStyle(
                          fontSize: 23.0,
                        ),
                        children: [
                          new TextSpan(
                            text: "Color rgb: ",
                            style: new TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          new TextSpan(
                            text: "$red, ",
                            style: new TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          new TextSpan(
                            text: "$green ",
                            style: new TextStyle(
                              color: Colors.green,
                            ),
                          ),
                          new TextSpan(
                            text: "$blue",
                            style: new TextStyle(
                              color: Colors.blue,
                            ),
                          )
                        ]),
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: new RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: new Text("generate"),
                        onPressed: () {
                          _randomColor();
                        }),
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
