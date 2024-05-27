import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_weather/model/current_response_model.dart';
import 'package:getx_weather/model/forecast_response_model.dart';
import 'package:getx_weather/utils/constants.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  var isCurrentLoading = true.obs;
  var isLoading = true.obs;
  var currentData = Rxn<CurrentWeatherModel>();
  var forecastData = Rxn<ForecastWeatherResponse>();

  @override
  void onInit() {
    fetchCurrentWeather();
    fetchForecastWeather();

    super.onInit();
  }

  Future<void> fetchForecastWeather() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(
          '${baseUrl}data/2.5/forecast?lat=24.3746&lon=88.6004&appid=$apiKey&units=metric'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        forecastData.value = ForecastWeatherResponse.fromJson(jsonData);
      }
    } catch (e) {
      print("Error fetching weather data: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchCurrentWeather() async {
    try {
      isCurrentLoading(true);
      var response = await http.get(Uri.parse(
          '${baseUrl}data/2.5/weather?lat=24.3746&lon=88.6004&appid=$apiKey&units=metric'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        currentData.value = CurrentWeatherModel.fromJson(jsonData);
      }
    } catch (e) {
      print("Error fetching weather data: ${e.toString()}");
    } finally {
      isCurrentLoading(false);
    }
  }
}
