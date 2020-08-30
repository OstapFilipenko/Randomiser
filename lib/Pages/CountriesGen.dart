import 'dart:async';
import 'package:flutter/services.dart';
import 'package:iso_countries/iso_countries.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:webview_flutter/webview_flutter.dart';

class CountriesGen extends StatefulWidget {
  @override
  _CountriesGen createState() => _CountriesGen();
}

class _CountriesGen extends State<CountriesGen> {
  List<Country> countryList;
  WebViewController controller;
  Country country;
  int numb = 1;
  int oldnum;
  var rng = new Random();
  void initState() {
    super.initState();
    prepareDefaultCountries();
  }

  Future<void> prepareDefaultCountries() async {
    List<Country> countries;
    try {
      countries = await IsoCountries.iso_countries;
    } on PlatformException {
      countries = null;
    }
    if (!mounted) return;

    setState(() {
      countryList = countries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Center(
      child: countryList != null
          ? new ListView(
              scrollDirection: Axis.vertical,
              children: [
                new Card(
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
                        new Text(
                          countryList[numb].name,
                          style: new TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        new Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: new RaisedButton(
                              color: Colors.blue,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: new Text("generate"),
                              onPressed: () {
                                randomNumb(1, countryList.length);
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : new CircularProgressIndicator(),
    ));
  }

  void randomNumb(var min, var max) {
    oldnum = numb;
    setState(() {
      numb = min + rng.nextInt(max - min);
      if (numb == oldnum) {
        randomNumb(1, countryList.length);
      }
    });
  }
}
