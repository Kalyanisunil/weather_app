import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class WeatherCard extends StatelessWidget {
  final String iconPath;
  final String condition;
  final String value;

  const WeatherCard({
    Key? key,
    required this.iconPath,
    required this.condition,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // scrollDirection: Axis.horizontal,
      child: GlassmorphicContainer(
        width: 150,
        height: 150,
        borderRadius: 20,
        blur: 20,
        alignment: Alignment.bottomCenter,
        border: 2,
        linearGradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(45, 239, 239, 241).withOpacity(0.1),
              Color(0xFFFFFFFF).withOpacity(0.25),
            ],
            stops: [
              0.1,
              1,
            ]),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFffffff).withOpacity(0.5),
            const Color((0xFFFFFFFF)).withOpacity(0.5),
          ],
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0, top: 20),
                child: Center(
                  child: Image.asset(
                    iconPath,
                    width: 35,
                    height: 35,
                    color: Color.fromARGB(244, 255, 255, 255),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  condition,
                  style: TextStyle(
                      color: Color.fromARGB(255, 241, 239, 239), fontSize: 13),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Center(
                  child: Text(value,
                      style: TextStyle(
                          color: Color.fromARGB(236, 248, 246, 246),
                          fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
