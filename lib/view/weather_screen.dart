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
    final WeatherController weatherController = Get.put(WeatherController());
    return Material(
      //tried to make appbar look like ios
      child: CupertinoPageScaffold(
        backgroundColor: const Color(0xFF798ED6),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                backgroundColor: Colors.transparent,
                //make it observable, because i want to show current location in appbar
                largeTitle: Obx(
                  () => Text(
                    weatherController.isCurrentLoading.value
                        ? ""
                        : weatherController.currentData.value!.name!,
                  ),
                ),
                border: null,
              ),
            ];
          },
          //observable
          body: Column(
            children: [
              Obx(
                () {
                  if (weatherController.isCurrentLoading.value) {
                    return const SizedBox(
                        height: 200,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        )));
                  } else if (weatherController.currentData.value == null) {
                    return const Center(child: Text('No data found'));
                  } else {
                    var currentData = weatherController.currentData.value!;
                    return Card(
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
                                  '$iconPrefix${currentData.weather!.first.icon}$iconSuffix',
                                  fit: BoxFit.cover,
                                ),
                                Text(
                                  '${currentData.main!.temp}$degree$celsius',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50),
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
                                    Text(currentData.clouds!.all.toString()),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/icons/humidity.png",
                                      height: 35,
                                      width: 35,
                                    ),
                                    Text(currentData.main!.humidity.toString()),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/icons/windspeed.png",
                                      height: 35,
                                      width: 35,
                                    ),
                                    Text(currentData.wind!.speed.toString()),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
              Obx(() {
                if (weatherController.isLoading.value) {
                  return const SizedBox(
                      height: 300,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )));
                } else if (weatherController.forecastData.value == null) {
                  return const Center(child: Text('No data found'));
                } else {
                  var forecastWeather = weatherController.forecastData.value!;

                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: forecastWeather.list.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                            forecastWeather.list[index].dt
                                                    .toInt() *
                                                1000)),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  Text(
                                    DateFormat("dd/MM/yyyy").format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            forecastWeather.list[index].dt
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
                                '$iconPrefix${forecastWeather.list[index].weather.first.icon}$iconSuffix',
                                fit: BoxFit.cover,
                              ),
                              Text(
                                '${forecastWeather.list[index].main.temp}$degree$celsius',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
