import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'api.dart';
import 'dart:math';

Future<String> getOAuth() async {
  try {
    final response = await http.get(url_authorize);
    print("get response");
    if (response.statusCode == 200) {
      var rawData = response.body;
      print(rawData);
      return rawData;
    }
  } catch (error) {
    print(error);
    return "no/network";
  }
}
