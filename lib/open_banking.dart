import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'api.dart';
import 'dart:math';

const String clientID = 'c8efeb93-515a-42c3-9d2d-542817f805ae';
const String clientSecret = '475b94e3-a4da-47d0-9bbe-c83127e6a1fe';

Future<String> getOAuthfromServer() async {
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

Future<String> getOAuth() async {
  print('request to api directly');
  Map<String, dynamic> formdata = {
    'response_type': 'code',
    'client_id': clientID,
    'redirect_uri': 'http://13.209.74.234:5000/authorize',
    'scope': 'login inquiry transfer',
    'state': Random().nextInt(32),
    'auth_type': '0',
    'lang': 'kor',
    'cellphone_cert_yn': 'Y',
    'authorized_cert_yn': 'N',
    'account_hold_auth_yn': 'N'
  };
  try {
    final response = await Dio().get(
      'https://testapi.openbanking.or.kr/oauth/2.0/authorize',
      queryParameters: formdata
    );
    print("get response");
    if (response.statusCode == 200) {
      var rawData = response.data;
      print(rawData);
      return rawData;
    }
  } catch (error) {
    print(error);
    return "no/network";
  }
}