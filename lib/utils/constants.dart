import 'dart:ui';

import 'package:hive_flutter/hive_flutter.dart';

const String apiKey = "b567eba6c40f017dff2045dd2f1914cb";
const String baseUrl = "https://api.openweathermap.org/";

const String celsius = 'C';
const String fahrenheit = 'F';
const String metric = 'metric';
const String imperial = 'imperial';
const String degree = '\u00B0';

const String iconPrefix = 'https://openweathermap.org/img/wn/';
const String iconSuffix = '@2x.png';
//Hive box
late Box box;

class AppColors {
  static Color primary = Color(0xFF798ED6);
  static Color white50 = Color(0xFFFFFFFF).withOpacity(0.5);
}
