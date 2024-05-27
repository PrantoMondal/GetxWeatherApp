import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather/controller/weather_controller.dart';
import 'package:getx_weather/utils/constants.dart';
import 'package:getx_weather/view/search_screen.dart';
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
        backgroundColor: AppColors.primary,
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
                        : weatherController.currentData.value == null
                            ? ""
                            : weatherController.currentData.value!.name!,
                  ),
                ),
                border: null,
                padding: EdgeInsetsDirectional.zero,
                trailing: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SearchScreen.routeName,
                        arguments: [
                          weatherController.forecastData.value!.city.coord.lat,
                          weatherController.forecastData.value!.city.coord.lon
                        ]);
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
            ];
          },
          //observable
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.network(
                                '$iconPrefix${currentData.weather!.first.icon}$iconSuffix',
                                fit: BoxFit.cover,
                              ),
                              Container(
                                width: 1,
                                height: 60,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primary,
                                      Colors.black,
                                      AppColors.primary,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                              Text(
                                '${currentData.main!.temp?.toInt()}$degree$celsius',
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
                              customRowItem(
                                  image: "assets/icons/clouds.png",
                                  value: "${currentData.clouds!.all}%"),
                              customRowItem(
                                  image: "assets/icons/humidity.png",
                                  value: "${currentData.main!.humidity}%"),
                              customRowItem(
                                  image: "assets/icons/windspeed.png",
                                  value: "${currentData.wind!.speed}km/h"),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Today",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() {
                  if (weatherController.isLoading.value) {
                    return const SizedBox(
                      height: 300,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else if (weatherController.forecastData.value == null) {
                    return const Center(child: Text('No data found'));
                  } else {
                    var forecastWeather = weatherController.forecastData.value!;

                    return SizedBox(
                      height: 140,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: weatherController.todayForecast.length +
                            1, //added 1 for showing 12 am with today list
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: index == 0
                                    ? Colors.blue
                                    : AppColors.white50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat("hh:mm a").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          forecastWeather.list[index].dt
                                                  .toInt() *
                                              1000)),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: index == 0
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Image.network(
                                  '$iconPrefix${forecastWeather.list[index].weather.first.icon}$iconSuffix',
                                  fit: BoxFit.cover,
                                  width: 50,
                                ),
                                Text(
                                  '${forecastWeather.list[index].main.temp.toInt()}$degree$celsius',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: index == 0
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Upcoming",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20)
                          .copyWith(top: 10),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          color: AppColors.white50),
                      child: ListView.builder(
                        // scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: weatherController.upcomingForecast.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormat("d/MM/yyyy").format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            weatherController
                                                    .upcomingForecast[index].dt
                                                    .toInt() *
                                                1000)),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    DateFormat("hh:mm a").format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            weatherController
                                                    .upcomingForecast[index].dt
                                                    .toInt() *
                                                1000)),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  const Spacer(),
                                  Image.network(
                                    '$iconPrefix${weatherController.upcomingForecast[index].weather.first.icon}$iconSuffix',
                                    fit: BoxFit.cover,
                                    width: 50,
                                  ),
                                  Text(
                                    '${weatherController.upcomingForecast[index].main.temp.toInt()}$degree$celsius',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                              Divider(
                                color: AppColors.primary,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  customRowItem({required String image, required String value}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16)),
          child: Image.asset(
            image,
            height: 35,
            width: 35,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(value),
      ],
    );
  }
}
