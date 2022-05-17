import 'package:geolocator/geolocator.dart';

class Location {
  Location({this.lat, this.lon});
  double lat;
  double lon;

  void getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      lat = position.latitude;
      lon = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
