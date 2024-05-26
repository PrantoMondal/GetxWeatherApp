import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather/controller/counter_controller.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    final CounterController controller = Get.put(CounterController());
    return CupertinoPageScaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CupertinoSliverNavigationBar(
                backgroundColor: Theme.of(context).colorScheme.background,
                largeTitle: Text(
                  "Task 2",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                border: null,
              ),
            ];
          },
          body: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => Text(
                      controller.count.toString(),
                      style: const TextStyle(fontSize: 50),
                    )),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: CupertinoColors.activeBlue,
                      child: const Text('Decrement'),
                      onPressed: () {
                        controller.decrement();
                      },
                    ),
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: CupertinoColors.activeBlue,
                      child: const Text('Increment'),
                      onPressed: () {
                        controller.increment();
                        print(controller.count.value);
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  color: CupertinoColors.activeBlue,
                  child: const Text('Reset'),
                  onPressed: () {
                    controller.reset();
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
