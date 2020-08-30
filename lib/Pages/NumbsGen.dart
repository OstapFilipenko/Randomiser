import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';

class NumbersGen extends StatefulWidget {
  @override
  _NumbersGen createState() => _NumbersGen();
}

class _NumbersGen extends State<NumbersGen> {
  int _numb = 0;
  var rng = new Random();
  final _minValueController = new TextEditingController();
  final _maxValueController = new TextEditingController();

  void _randomNumb(var min, var max) {
    setState(() {
      _numb = min + rng.nextInt(max - min);
    });
  }

  @override
  void dispose() {
    _minValueController.dispose();
    _maxValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Container(
                  width: 100,
                  child: new TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter a number";
                      }
                      return null;
                    },
                    controller: _minValueController,
                    decoration: new InputDecoration(
                      labelText: "Min",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                new Container(
                  width: 100,
                  child: new TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please enter a number";
                      }
                      return null;
                    },
                    controller: _maxValueController,
                    decoration: new InputDecoration(
                      labelText: "Max",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                  ),
                )
              ],
            ),
          ),
          new Text(
            'Your random number is:',
            style: new TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
          new Text(
            '$_numb',
            style: new TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
          new RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text("generate"),
              onPressed: () {
                _randomNumb(int.parse(_minValueController.text),
                    int.parse(_maxValueController.text) + 1);
              })
        ],
      ),
    );
  }
}
