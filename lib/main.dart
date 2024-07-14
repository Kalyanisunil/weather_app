import 'package:flutter/material.dart';

import 'package:weather_app/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFF778da9)),
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      // home: const SplashScreen());
      home: const SplashScreen(),
    );
  }
}
