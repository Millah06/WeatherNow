import 'package:geolocator/geolocator.dart';

class Location {

  double ? latitute;
  double ? longtute;

  Future<void> getCurrentLocation () async {

    LocationPermission permission = await Geolocator.requestPermission();

    LocationSettings locationSettings = LocationSettings(accuracy: LocationAccuracy.best);
    try {
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);

      latitute = position.latitude;
      longtute = position.longitude;
    } catch(e) {
      print(e);
    }
  }
}