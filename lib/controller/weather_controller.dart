import 'dart:convert';

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
    fetchCurrentWeather();
    fetchForecastWeather();

    super.onInit();
  }

  Future<void> fetchCurrentWeather() async {
    try {
      isCurrentLoading(true);
      var response = await http.get(Uri.parse(
          '${baseUrl}data/2.5/weather?lat=24.3746&lon=88.6004&appid=$apiKey&units=metric'));
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

  Future<void> fetchForecastWeather() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(
          '${baseUrl}data/2.5/forecast?lat=24.3746&lon=88.6004&appid=$apiKey&units=metric'));
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
