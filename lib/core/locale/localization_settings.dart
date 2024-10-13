// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

import 'app_loacl.dart';



//  localizationsDelegatesList
const localizationsDelegatesList = [
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  AppLocalizations.delegate,
];

//  supportedLocalesList
const supportedLocalesList = [
  Locale('ar', "EG"),
  Locale('en', "US"),
];
