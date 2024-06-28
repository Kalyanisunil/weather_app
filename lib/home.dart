// import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/weather.dart';
// import 'package:weather_app/BottomBar.dart';
import 'package:weather_app/consts.dart';
import 'package:weather_app/suggestions.dart';

import 'package:weather_app/weathercard.dart';
// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? weather;
  late String weatherCondition = "sunny";
  @override
  void initState() {
    super.initState();
    _fetchWeatherData("Kallambalam");
  }

  Future<void> _fetchWeatherData(String cityName) async {
    final Weather w = await _wf.currentWeatherByCityName(cityName);
    setState(() {
      weather = w;
      weatherCondition = weather!.weatherMain!;
    });
  }

  String getAnimationsforweather(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
      case 'sunny':
        return 'assets/Lottie/sunny.json';

      case 'rain':
      case 'raining':
        return 'assets/Lottie/Night_rain.json';

      case 'clouds':
      case 'cloudy':
        return 'assets/Lottie/clouds.json';

      default:
        return 'assets/Lottie/Night_rain.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => {},
          icon: const Icon(Icons.menu),
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.calendar_month),
            color: Colors.white,
          ),
        ],
        backgroundColor: Color.fromARGB(255, 76, 139, 211),
      ),
      body: _buildWeather(),
    );
  }

  Widget _buildWeather() {
    // DateTime today = DateTime.now();
    if (weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    Widget locationName() {
      return Text(
        weather?.areaName ?? "",
        style: const TextStyle(fontSize: 17, color: Colors.white),
      );
    }

    DateTime now = weather!.date!;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromARGB(255, 76, 139, 211), // Deep Navy Blue
                  Color.fromARGB(255, 133, 160, 210), // Dark Slate Blue
                  Color.fromARGB(255, 138, 173, 212), // Cool Grey Blue
                  Color.fromARGB(255, 94, 110, 131),
                ])),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Center(
                        child: Text(DateFormat(" EEEE").format(now),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20)),
                      ),
                      Center(
                        child: Text(DateFormat(" h:mm a").format(now),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0, 265, 0),
                    child: locationName(),
                  ),
                  Row(
                    children: [
                      Lottie.asset(
                        getAnimationsforweather(weatherCondition),
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.5),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.5),
                          child: Text(
                            ' ${weather!.temperature!.celsius?.toStringAsFixed(1)}°C',
                            style: const TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.5),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.5),
                      child: Text(
                        ' ${weather!.weatherDescription}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.5),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.5),
                      child: Text(
                        ' Feels like ${weather!.tempFeelsLike}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/sun.png",
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        // Text(
                        //   '${weather!.humidity}',
                        //   style: const TextStyle(color: Colors.white),
                        // ),
                        const SizedBox(
                          width: 65,
                        ),
                        Image.asset(
                          "assets/images/cloudysunny.png",
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '${weather!.tempMax!.celsius?.toStringAsFixed(1)}°C',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          width: 50.0,
                        ),
                        Image.asset(
                          "assets/icons/windy.png",
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "${weather!.windSpeed}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.hourglass_empty,
                        color: Colors.white,
                      ),
                      Text(
                        "More Info",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 21.5,
                  ),
                  CarouselSlider(
                    items: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: WeatherCard(
                            iconPath: 'assets/icons/windy.png',
                            condition: "Humidity",
                            value: "${weather!.humidity}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: WeatherCard(
                            iconPath: 'assets/icons/rainy.png',
                            condition: "Cloudy",
                            value: "${weather!.cloudiness}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: WeatherCard(
                            iconPath: 'assets/icons/sun.png',
                            condition: "Wind Degree",
                            value: "${weather!.windDegree}"),
                      ),
                    ],
                    options: CarouselOptions(
                      height: 182,
                      aspectRatio: 16 / 9,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      viewportFraction: 0.3,
                    ),
                  ),
                  const Suggestions(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
