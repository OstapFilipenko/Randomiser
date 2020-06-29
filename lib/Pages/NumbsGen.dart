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
            body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Container(
                    width: 100,
                    child: new TextField(  
                      controller: _minValueController,
                      decoration: new InputDecoration.collapsed(
                        hintText: "Min"
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                    ),
                  ),
                 new Container(
                    width: 100,
                    child: new TextField(  
                      controller: _maxValueController,
                     decoration: new InputDecoration.collapsed(
                        hintText: "Max"
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                    ),
                  )
              ],
            ),
            new Text(
              'Your random number is:',
            ),
            new Text(
              '$_numb',
              style: Theme.of(context).textTheme.headline4,
            ),
            new RaisedButton(
              child: const Text("generate"),
              onPressed: (){
                _randomNumb(int.parse(_minValueController.text), int.parse(_maxValueController.text)+1);
              }
            )
          ],
        ),
      ),
    );
  }
}