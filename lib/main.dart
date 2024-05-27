import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:getx_weather/hive/hiveDB.dart';
import 'package:getx_weather/utils/constants.dart';
import 'package:getx_weather/view/search_screen.dart';
import 'package:getx_weather/view/weather_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveDBAdapter());
  box = await Hive.openBox<HiveDB>('currentWeather');
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
        SearchScreen.routeName: (_) => const SearchScreen(),
      },
    );
  }
}
