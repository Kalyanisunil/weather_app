// import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/weather.dart';
// import 'package:weather_app/BottomBar.dart';
import 'package:weather_app/consts.dart';
// import 'package:weather_app/reallocation.dart';

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
  late List<Gradient> gradients;
  @override
  void initState() {
    super.initState();
     _determinePosition().then((position) {
      _getCityNameFromCoordinates(position.latitude, position.longitude)
          .then((cityName) {
        _fetchWeatherData(cityName);
      });
    });
    gradients = [
      const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromARGB(255, 76, 139, 211), // Deep Navy Blue
          Color.fromARGB(255, 133, 160, 210), // Dark Slate Blue
          Color.fromARGB(255, 138, 173, 212), // Cool Grey Blue
          Color.fromARGB(255, 94, 110, 131)
        ],
      ),
      const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 241, 236, 84),
            Color.fromARGB(255, 210, 210, 133), //
            Color.fromARGB(255, 212, 203, 138), //
            Color.fromARGB(255, 210, 153, 83),
          ]),
      const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 94, 110, 131),
            Color.fromARGB(255, 24, 27, 30),
            Color.fromARGB(255, 30, 35, 45), //
            Color.fromARGB(255, 36, 47, 60), //
          ]),
    ];
  }

  Future<void> _fetchWeatherData(String cityName) async {
    final Weather w = await _wf.currentWeatherByCityName(cityName);
    setState(() {
      weather = w;
      weatherCondition = weather!.weatherMain!;
    });
  }
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
 Future<String> _getCityNameFromCoordinates(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    return place.locality ?? "Unknown";
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
    DateTime now = weather!.date!;
    int currentHour = now.hour;

    int gradientIndex = 0;
    if (currentHour >= 6 && currentHour < 12) {
      gradientIndex = 0; // Morning gradient
    } else if (currentHour >= 12 && currentHour < 18) {
      gradientIndex = 1; // Afternoon gradient
    } else {
      gradientIndex = 2; // Evening gradient
    }

    Widget locationName() {
      return Text(
        weather?.areaName ?? "",
        style: const TextStyle(fontSize: 17, color: Colors.white),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: gradients[gradientIndex],
            ),
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
                  // const Suggestions(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
