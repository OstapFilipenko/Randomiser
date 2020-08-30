import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:connectivity/connectivity.dart';
import 'package:randomiser/ApiCon.dart';
import 'package:randomiser/Models/Country.dart';
import 'package:url_launcher/url_launcher.dart';

class CountriesGen extends StatefulWidget {
  @override
  _CountriesGen createState() => _CountriesGen();
}

class _CountriesGen extends State<CountriesGen> {
  List<Country> countryList;
  int numb = 1;
  int oldnum;
  var connection = false;
  var rng = new Random();
  void initState() {
    super.initState();
    //prepareDefaultCountries();
    _getCountries();
    check().then((internet) {
      if (internet != null && internet) {
        connection = true;
      } else {
        connection = false;
      }
    });
  }

  _getCountries() async {
    var countries = await ApiCon().getCountries();
    setState(() {
      countryList = countries;
    });
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: connection && countryList != null
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
                  new Container(
                    margin: EdgeInsets.only(top: 50.0, bottom: 20.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            new Text(
                              "Capital ",
                              style: new TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            new Icon(
                              Icons.location_city,
                              size: 30.0,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        new SizedBox(
                          height: 10.0,
                          width: 20.0,
                        ),
                        new Text(
                          countryList[numb].capital,
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        new Divider(),
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            new Text(
                              "Abbreviation ",
                              style: new TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            new Icon(
                              Icons.sort_by_alpha,
                              size: 30.0,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        new SizedBox(
                          height: 10.0,
                          width: 20.0,
                        ),
                        new Text(
                          countryList[numb].abbreviation,
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        new Divider(),
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            new Text(
                              "Region ",
                              style: new TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            new Icon(
                              Icons.map,
                              size: 30.0,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        new SizedBox(
                          height: 10.0,
                          width: 20.0,
                        ),
                        new Text(
                          countryList[numb].region +
                              ", " +
                              countryList[numb].subregion,
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        new Divider(),
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            new Text(
                              "Population ",
                              style: new TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            new Icon(
                              Icons.people,
                              size: 30.0,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        new SizedBox(
                          height: 10.0,
                          width: 20.0,
                        ),
                        new Text(
                          countryList[numb].population.toString(),
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        new Divider(),
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            new Text(
                              "Area ",
                              style: new TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            new Icon(
                              Icons.format_shapes,
                              size: 30.0,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        new SizedBox(
                          height: 10.0,
                          width: 20.0,
                        ),
                        new Text(
                          countryList[numb].area.toString(),
                          style: new TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        new Divider(),
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            new Text(
                              "Flag ",
                              style: new TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            new Icon(
                              Icons.flag,
                              size: 30.0,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        new SizedBox(
                          height: 10.0,
                          width: 20.0,
                        ),
                        new GestureDetector(
                          child: new Text(
                            countryList[numb].pathFlag,
                            style: new TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          onTap: () => launch(countryList[numb].pathFlag),
                        )
                      ],
                    ),
                  )
                ],
              )
            : new CircularProgressIndicator(),
      ),
    );
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
