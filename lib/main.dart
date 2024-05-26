import 'package:flutter/material.dart';
import 'package:getx_weather/view/search_screen.dart';
import 'package:getx_weather/view/settings_screen.dart';
import 'package:getx_weather/view/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: WeatherScreen.routeName,
      routes: {
        WeatherScreen.routeName: (_) => const WeatherScreen(),
        SearchScreen.routeName: (_) => const SettingsScreen(),
        SettingsScreen.routeName: (_) => const SettingsScreen(),
      },
    );
  }
}
