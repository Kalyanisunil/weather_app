import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/BottomBar.dart';
// import 'package:weather_app/home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen(
        useImmersiveMode: true,
        duration: const Duration(milliseconds: 2000),
        nextScreen: const MyBottomBar(),
        backgroundColor: Color.fromARGB(255, 107, 162, 236),
        splashScreenBody: Center(
          child: Lottie.asset(
            'assets/Lottie/clouds.json',
            width: 100,
            height: 100,
            repeat: false,
          ),
        
        ),
      ),
    );
  }
}
