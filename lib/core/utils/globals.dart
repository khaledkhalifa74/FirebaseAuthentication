library;
import 'dart:ui';
import 'package:firebase_features/main.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
String appLang = PlatformDispatcher.instance.locale.languageCode;

String convertArabicNumbersToEnglish(String input) {
  const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  const englishDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

  for (int i = 0; i < arabicDigits.length; i++) {
    input = input.replaceAll(arabicDigits[i], englishDigits[i]);
  }
  return input;
}

Future<void> restartApp() async {
  runApp(MyApp());
}
