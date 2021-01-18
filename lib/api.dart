import 'package:oauth2_client/oauth2_client.dart';

const String customScheme = "alarm.transfer";
const String clientID = "c8efeb93-515a-42c3-9d2d-542817f805ae";
const String clientSecret = "475b94e3-a4da-47d0-9bbe-c83127e6a1fe";
const String redirectUri = 'https://www.alarm-transfer.com/redirect-uri';

const url_authorize = "https://openapi.openbanking.or.kr/oauth/2.0/authorize";

OAuth2Client myOAuth2Client = OAuth2Client(
    customUriScheme: 'https',
    redirectUri: redirectUri,
    authorizeUrl: redirectUri + '/authorize',
    tokenUrl: redirectUri + '/token');