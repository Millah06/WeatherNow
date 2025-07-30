import 'package:weather/services/location.dart';
import 'package:weather/services/networking.dart';

const openWeatherUrl = 'https://api.openweathermap.org/data/2.5/weather';
const apiKey = 'a0d5b18961fab1911fb8c41fe7ad64c4';

class WeatherModel {

  Future<dynamic> getCityWeather (String cityName) async  {
    var url = '$openWeatherUrl?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    return await networkHelper.getWeatherData();
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(url:
    '$openWeatherUrl?lat=${location.latitute}&lon=${location.longtute}&'
        'appid=$apiKey&units=metric');
    dynamic weatherData = await networkHelper.getWeatherData();
    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
