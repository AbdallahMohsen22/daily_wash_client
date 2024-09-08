import 'package:flutter/material.dart';

class AppConstants {
  static const languageCode = "language_code";
  static const countryCode = "country_code";
  static const appName = "Daily Wash";
  static String initScreen = "initScreen";

  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
}

String? token;
String? userId;
String? fcmToken;
String myLocale = 'en';
int? code;
bool? isConnect;

