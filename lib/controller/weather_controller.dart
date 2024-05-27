import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:getx_weather/hive/hiveDB.dart';
import 'package:getx_weather/model/current_response_model.dart';
import 'package:getx_weather/model/forecast_response_model.dart';
import 'package:getx_weather/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  var isCurrentLoading = true.obs;
  var isLoading = true.obs;
  var currentData = Rxn<CurrentWeatherModel>();
  var forecastData = Rxn<ForecastWeatherResponse>();
  var todayForecast = <WeatherData>[].obs;
  var upcomingForecast = <WeatherData>[].obs;

  @override
  void onInit() {
    _determinePosition();

    fetchCurrentWeather();
    fetchForecastWeather();

    super.onInit();
  }

  Future<void> fetchCurrentWeather({String? city}) async {
    Position position = await Geolocator.getCurrentPosition();
    try {
      isCurrentLoading(true);
      var response = city != null
          ? await await http.get(Uri.parse(
              '${baseUrl}data/2.5/weather?q=$city&appid=$apiKey&units=metric'))
          : await http.get(Uri.parse(
              '${baseUrl}data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        currentData.value = CurrentWeatherModel.fromJson(jsonData);

        box.put(
            "current",
            HiveDB(
              main: currentData.value!.main!,
              weather: currentData.value!.weather,
              clouds: currentData.value!.clouds!,
              wind: currentData.value!.wind!,
            ));
        print("Saved to local storage");
      }
    } catch (e) {
      print("Error fetching weather data: ${e.toString()}");
    } finally {
      isCurrentLoading(false);
    }
  }

  Future<void> fetchForecastWeather({String? city}) async {
    Position position = await Geolocator.getCurrentPosition();
    try {
      isLoading(true);
      var response = city != null
          ? await await http.get(Uri.parse(
              '${baseUrl}data/2.5/forecast?q=$city&appid=$apiKey&units=metric'))
          : await http.get(Uri.parse(
              '${baseUrl}data/2.5/forecast?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        forecastData.value = ForecastWeatherResponse.fromJson(jsonData);

        filterUpcomingData(forecastData.value!);
        filterTodayData(forecastData.value!);
      }
    } catch (e) {
      print("Error fetching weather data: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  void filterTodayData(ForecastWeatherResponse forecastWeather) {
    final today = DateTime.now();
    todayForecast.value = forecastWeather.list.where((entry) {
      final entryDate =
          DateTime.fromMillisecondsSinceEpoch(entry.dt.toInt() * 1000);
      return entryDate.year == today.year &&
          entryDate.month == today.month &&
          entryDate.day == today.day;
    }).toList();
    print("--------------------------");
    print(todayForecast.length);
  }

  void filterUpcomingData(ForecastWeatherResponse forecastWeather) {
    final today = DateTime.now();
    upcomingForecast.value = forecastWeather.list.where((entry) {
      final entryDate =
          DateTime.fromMillisecondsSinceEpoch(entry.dt.toInt() * 1000);
      return !(entryDate.year == today.year &&
          entryDate.month == today.month &&
          entryDate.day == today.day);
    }).toList();

    print(upcomingForecast.length);
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
