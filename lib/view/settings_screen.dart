import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  static String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final String argument =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: Center(
        child: Text(
          argument,
          style: const TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
