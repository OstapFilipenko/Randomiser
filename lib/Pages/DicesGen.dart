import 'package:flutter/material.dart';
import 'dart:math';

class DicesGen extends StatefulWidget {
  @override
  _DicesGen createState() => _DicesGen();
}

class _DicesGen extends State<DicesGen> {
  int numb = 1;
  int oldnum;
  var rng = new Random();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: new FlatButton(
          onPressed: () {
            randomNumb(1, 7);
          },
          child: new Image(
            image: AssetImage('assets/img/dice-$numb.png'),
          ),
        ),
      ),
    );
  }

  void randomNumb(var min, var max) {
    oldnum = numb;
    setState(() {
      numb = min + rng.nextInt(max - min);
      if (numb == oldnum) {
        randomNumb(1, 7);
      }
    });
  }
}
