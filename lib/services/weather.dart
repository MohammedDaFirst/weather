import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = 'f9e999d1f91df0cc4e6c3be98a5ec324';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/onecall';

class WeatherModel {
  Future<dynamic> getLocationWeahter() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapUrl?lat=${location.lat}&lon=${location.lon}&exclude=hourly,daily&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getCityWeather(cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&appid=$apiKey');

    var location = await networkHelper.getData();

    NetworkHelper networkHelper2 = NetworkHelper(
        '$openWeatherMapUrl?lat=${location[0]['lat']}&lon=${location[0]['lon']}&exclude=hourly,daily&appid=$apiKey&units=metric');
    var weatherData = await networkHelper2.getData();
    print(weatherData);
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
