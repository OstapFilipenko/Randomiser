import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:iso_countries/iso_countries.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';

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
  var url = 'https://en.wikipedia.org/wiki/albania';

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
                  color: Colors.white,
                  child: new Container(
                    padding: EdgeInsets.all(20.0),
                    child: new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text(countryList[numb].name),
                        new RaisedButton(
                            child: new Text("generate"),
                            onPressed: () {
                              randomNumb(1, countryList.length);
                              setState(() {
                                url = 'https://en.wikipedia.org/wiki/' +
                                    countryList[numb].name;
                                controller.loadUrl(url);
                              });
                            })
                      ],
                    ),
                  ),
                ),
                new Container(
                  height: MediaQuery.of(context).size.height,
                  child: new WebView(
                    initialUrl: url,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      controller = webViewController;
                    },
                    gestureRecognizers: Set()
                      ..add(Factory<VerticalDragGestureRecognizer>(
                          () => VerticalDragGestureRecognizer())),
                  ),
                )
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
