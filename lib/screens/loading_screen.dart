import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/services/weather.dart';

import 'location_screen.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';



class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});


  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}



class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLocation();
  }





  void getLocation() async {

    WeatherModel weatherModel = WeatherModel();
    dynamic weatherData = await weatherModel.getLocationWeather();
    Timer(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LocationScreen(weather: weatherData,)));
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        children: [
          Expanded(
            flex: 7,
              child:
              Image.asset('images/img.png')
          ),
          Expanded(
            flex: 2,
              child:
              Column(
                children: [
                  Text('Welcome to WeatherApp',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 25,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                  Text('Powered by Millah Technology',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 19,
                        fontWeight: FontWeight.w900
                    ),
                  ),
                  SpinKitChasingDots(
                    color: Colors.white,
                    size: 70,
                    duration: Duration(seconds: 3),
                  ),
                ],
              )
          )
        ],
      )
    );
  }
}
