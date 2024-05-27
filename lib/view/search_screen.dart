import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:getx_weather/utils/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controller/weather_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });
  static String routeName = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final TextEditingController controller = TextEditingController();

  final WeatherController weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    final position = ModalRoute.of(context)?.settings.arguments as List<double>;
    final latitude = position[0];
    final longitude = position[1];
    print("==============");
    print(latitude);
    print(longitude);

    return Material(
        child: CupertinoPageScaffold(
      backgroundColor: AppColors.primary,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            const CupertinoSliverNavigationBar(
              backgroundColor: Colors.transparent,
              largeTitle: Text(
                "Search",
              ),
              border: null,
              padding: EdgeInsetsDirectional.zero,
            ),
          ];
        },
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 20)
                            .copyWith(left: 20),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        filled: true,
                        fillColor: AppColors.white50,
                        isDense: true,
                        hintText: "Search a city",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            weatherController.fetchCurrentWeather(
                                city: controller.text);
                            weatherController.fetchForecastWeather(
                                city: controller.text);
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 18.0),
                            child: SizedBox(
                                height: 24,
                                width: 24,
                                child: Icon(Icons.search)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  FloatingActionButton(
                    elevation: 0,
                    onPressed: _goToCurrentPosition,
                    child: const Icon(Icons.my_location),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(latitude, longitude),
                  zoom: 15,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> _goToCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition();
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(position.latitude, position.longitude),
          zoom: 15,
        ),
      ),
    );
  }
}
