import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'Models/Country.dart';

class ApiCon {
  Future<List<Country>> getCountries() async {
    List<Country> list;
    var res = await http.get(
      "https://restcountries.eu/rest/v2/all",
      headers: {'Accept': 'application/json'},
    );
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body) as List;
      print(data);
      list = data.map<Country>((json) => Country.fromJson(json)).toList();
    }
    print(list.length);
    return list;
  }
}
