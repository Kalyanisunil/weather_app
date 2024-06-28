import 'package:flutter/material.dart';
// import 'package:weather_app/BottomBar.dart';
// import 'package:weather_app/home.dart';
import 'package:weather_app/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//https://in.pinterest.com/pin/885942557926263679/
  // This widget is the root of your application.
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
