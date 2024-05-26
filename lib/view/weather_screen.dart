import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx_weather/view/settings_screen.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                backgroundColor: Theme.of(context).colorScheme.background,
                largeTitle: Text(
                  "Dhaka",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                border: null,
              ),
            ];
          },
          body: Container(
            child: Center(
              child: CupertinoButton(
                color: CupertinoColors.activeBlue,
                child: const Text('Settings'),
                onPressed: () {
                  Navigator.pushNamed(context, SettingsScreen.routeName,
                      arguments: "Hello");
                },
              ),
            ),
          ),
        ));
  }
}
