import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:getx_weather/model/current_response_model.dart';
import 'package:getx_weather/model/forecast_response_model.dart';
import 'package:getx_weather/utils/constants.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  var isLoading = true.obs;
  var forecastData = Rxn<ForecastWeatherResponse>();

  @override
  void onInit() {
    fetchForecastWeather();

    super.onInit();
  }

  void fetchForecastWeather() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(
          '${baseUrl}data/2.5/forecast?lat=24.3746&lon=88.6004&appid=$apiKey&units=metric'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        print(jsonData);
        print("-------------------------");
        print(ForecastWeatherResponse.fromJson(jsonData));
        print("----------------------------");
        forecastData.value = ForecastWeatherResponse.fromJson(jsonData);
      }
    } catch (e) {
      print("Error fetching weather data: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
}
