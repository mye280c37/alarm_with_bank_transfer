import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:oauth2_client/oauth2_client.dart';

import 'api.dart';
import 'dart:math';

OAuth2Client myOAuth2Client = OAuth2Client(
    redirectUri: redirectUri,
    authorizeUrl: redirectUri + '/authorize',
    tokenUrl: redirectUri + '/token');

Future<String> getOAuth() async {
  print("start authorization");
  Map<String, String> formData = {
    'response_type': 'code',
    'client_id': clientID,
    'redirect_uri': myOAuth2Client.authorizeUrl,
    'scope': 'login inquiry transfer',
    'state': Random().nextInt(99).toString(),
    'auth_type': '0'
  };
  try {
    var response = await Dio().get(url_authorize, queryParameters: formData);
    print("get response");
    if (response.statusCode == 200) {
      var rawData = response.data;
      print(rawData);
      print(rawData['code']);
      return rawData['code'];
    }
  } catch (error) {
    print(error);
    return "no/network";
  }
}
