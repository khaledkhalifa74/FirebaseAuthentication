library;
import 'dart:ui';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
String appLang = PlatformDispatcher.instance.locale.languageCode;
