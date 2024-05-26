import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:getx_weather/model/current_response_model.dart';
import 'package:getx_weather/utils/constants.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  var isLoading = true.obs;
  var currentWeather = Rxn<WeatherResponse>();

  @override
  void onInit() {
    fetchCurrentWeather();

    super.onInit();
  }

  void fetchCurrentWeather() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(
          '${baseUrl}data/2.5/forecast?lat=24.3746&lon=88.6004&appid=$apiKey&units=metric'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        print(jsonData);
        print("-------------------------");
        print(WeatherResponse.fromJson(jsonData));
        print("----------------------------");
        currentWeather.value = WeatherResponse.fromJson(jsonData);
      }
    } catch (e) {
      print("Error fetching weather data: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
}
