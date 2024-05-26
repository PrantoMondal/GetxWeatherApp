import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather/controller/weather_controller.dart';
import 'package:getx_weather/utils/constants.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    final WeatherController currentWeatherController =
        Get.put(WeatherController());
    return Material(
      child: CupertinoPageScaffold(
        backgroundColor: Color(0xFF798ED6),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                backgroundColor: Colors.transparent,
                largeTitle: Obx(
                  () => Text(
                    currentWeatherController.isLoading.value
                        ? ""
                        : currentWeatherController
                            .currentWeather.value!.city.name,
                  ),
                ),
                border: null,
              ),
            ];
          },
          body: Obx(() {
            if (currentWeatherController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (currentWeatherController.currentWeather.value == null) {
              return const Center(child: Text('No data found'));
            } else {
              var currentWeather =
                  currentWeatherController.currentWeather.value!;
              var present = currentWeather.list.first;
              return Column(
                children: [
                  Card(
                    color: Colors.white.withOpacity(0.7),
                    elevation: 4,
                    margin: const EdgeInsets.all(20.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.network(
                                '$iconPrefix${present.weather.first.icon}$iconSuffix',
                                fit: BoxFit.cover,
                              ),
                              Text(
                                '${present.main.temp}$degree$celsius',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 50),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/icons/clouds.png",
                                    height: 35,
                                    width: 35,
                                  ),
                                  Text(present.clouds.all.toString()),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/icons/humidity.png",
                                    height: 35,
                                    width: 35,
                                  ),
                                  Text(present.main.humidity.toString()),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/icons/windspeed.png",
                                    height: 35,
                                    width: 35,
                                  ),
                                  Text(present.wind.speed.toString()),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: currentWeather.list.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white.withOpacity(0.9)),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    DateFormat("hh:mm a").format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            currentWeather.list[index].dt
                                                    .toInt() *
                                                1000)),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  Text(
                                    DateFormat("dd/MM/yyyy").format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            currentWeather.list[index].dt
                                                    .toInt() *
                                                1000)),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Image.network(
                                '$iconPrefix${currentWeather.list[index].weather.first.icon}$iconSuffix',
                                fit: BoxFit.cover,
                              ),
                              Text(
                                '${currentWeather.list[index].main.temp}$degree$celsius',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
