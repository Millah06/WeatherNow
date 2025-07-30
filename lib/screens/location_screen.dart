import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weather/screens/city_screen.dart';
import 'package:weather/utilities/constants.dart';
import 'package:weather/services/weather.dart';
import 'package:weather/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {

  const LocationScreen({super.key, required this.weather});

  final dynamic weather;


  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int ? temperature;
  String  ? conditionIcon;
  String ? cityName;
  String weatherMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.weather);
    updateUI(widget.weather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        conditionIcon = 'Error';
        weatherMessage = 'Unavailable to get weather data';
        cityName = 'this area, try checking your internet connection';
        return;
      }
      double tempa = weatherData['main']['temp'];
      temperature = tempa.toInt();
      var condition = weatherData['weather'][0]['id'];
      conditionIcon = weatherModel.getWeatherIcon(condition!);
      weatherMessage = weatherModel.getMessage(temperature!);
      cityName = weatherData['name'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldLeave = await showDialog(context: context, builder: (context) =>
            AlertDialog(title: Text('Exit App!',),
              content: Text('Are you sure you want to exit?'),
              actions: [
                TextButton(onPressed: () {

                  Navigator.of(context).pop(false);
                },
                    child: Text('Cancel'),
                ),
                TextButton(onPressed: () {
                  exit(0);
                  Navigator.of(context).pop(true);
                },
                    child: Text('Exit'),
                )
              ],
            )
        );
        return shouldLeave;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/location_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        var typeName = await Navigator. push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => CityScreen(),
                          ),
                        );
                        if (typeName != null) {
                          var weatherData = await weatherModel.getCityWeather(typeName);
                          updateUI(weatherData);
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.search_outlined,
                            size: 30.0,
                          ),
                          Text('Tap to search any city here!',
                            style: TextStyle(
                                fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        dynamic weatherData = await weatherModel.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(50, 20, 0, 0 ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.near_me,
                              size: 30.0,
                              color: Colors.green,
                            ),
                            Text('Refresh to current location!',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontWeight: FontWeight.w900
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$temperature°C',
                        style: kTempTextStyle,
                      ),
                      Text(
                        '$conditionIcon',
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$weatherMessage in $cityName!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
