import 'package:http/http.dart';
import 'dart:convert';
class NetworkHelper {

  String url;
  double ? temperature;
  int ? condition;
  String ? cityName;


  NetworkHelper({required this.url});

  Future getWeatherData() async {

    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      dynamic decodedData = jsonDecode(response.body);
      return decodedData;
      // temperature = decodedData['main']['temp'];
      // condition = decodedData['weather'][0]['id'];
      // cityName = decodedData['name'];

    }


  }
}